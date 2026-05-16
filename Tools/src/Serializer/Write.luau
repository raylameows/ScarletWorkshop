local EncodingService = game:GetService("EncodingService")
local HttpService = game:GetService("HttpService")
local ScriptEditorService = game:GetService("ScriptEditorService")

local Shared = require(`./Shared`)
local Instances = require(`./Instances`)
local FeatureCheck = require(`../Util/FeatureCheck`)
local NodeTreeVisualizer = require(`../Util/NodeTreeVisualizer`)

local Write = {}
local RootNode: Shared.Node?
local RootObject: Instance?

local function WriteValue(value: any, valueType: string, propOrAtt: string?)
	local valueType = valueType or typeof(value)
	local call = Write[valueType]
	if not call then
		warn(`Type {valueType} of {propOrAtt and `{propOrAtt} ` or ``}{value} cannot be serialized`)
		return
	end

	return call(value)
end

local function GetIndex(object: Instance)
	local index = 1
	for _, child in (object.Parent:GetChildren()) do
		if child == object then
			return index
		elseif Instances[child.ClassName] ~= nil then
			index += 1
		end
	end

	return index
end

function Write.string(input: string)
	return input
end

function Write.number(number: number)
	return number
end

function Write.boolean(bool: boolean)
	return bool
end

function Write.Color3(color: Color3)
	return {color.R, color.G, color.B}
end

function Write.Vector3(vector: Vector3)
	return {vector.X, vector.Y, vector.Z}
end

function Write.CFrame(cf: CFrame)
	return {cf:GetComponents()}
end

function Write.UDim2(udim: UDim2)
	return {
		udim.X.Scale, udim.X.Offset,
		udim.Y.Scale, udim.Y.Offset
	}
end

function Write.EnumItem(enumItem: EnumItem)
	return tostring(enumItem)
end

function Write.BrickColor(color: BrickColor)
	return color.Number
end

function Write.NumberSequence(seq: NumberSequence)
	local keypoints = {}
	for _, k in (seq.Keypoints) do
		table.insert(keypoints, {
			Time = k.Time,
			Value = k.Value,
			Envelope = k.Envelope
		})
	end

	return keypoints
end

function Write.ColorSequence(seq: ColorSequence)
	local keypoints = {}
	for _, k in (seq.Keypoints) do
		table.insert(keypoints, {
			Time = k.Time,
			Color = Write.Color3(k.Value)
		})
	end

	return keypoints
end

function Write.NumberRange(range: NumberRange)
	return {range.Min, range.Max}
end

function Write.Rect(rect: Rect)
	return {
		rect.Min.X, rect.Min.Y,
		rect.Max.X, rect.Max.Y
	}
end

function Write.UDim(udim: UDim)
	return {udim.Scale, udim.Offset}
end

function Write.Vector2(vector: Vector2)
	return {vector.X, vector.Y}
end

function Write.InstanceReference(object: Instance?)
	if not object then return end
	
	local path = {}
	local current = object
	while current ~= RootObject do
		local index = GetIndex(current)
		if index then
			table.insert(path, index)
		end
		
		current = current.Parent
	end
	
	for i = 1, math.floor(#path / 2) do
		path[i], path[#path - i + 1] = path[#path - i + 1], path[i]
	end
	
	RootNode.Config.Expensives += 1
	return table.concat(path, `.`)
end

function Write.Instance(object: Instance, direct: boolean): Shared.Node
	if not Instances[object.ClassName] then
		warn(`Unknown instance {object.Name} of class {object.ClassName} will not be serialized`)
		return
	end
	
	local node: Shared.Node = {
		Class = object.ClassName,
		Properties = {},
		Attributes = {},
		Children = {}
	}
	if direct then
		RootNode = node
		RootNode.Config = {
			Expensives = 0,
		}
	end
	
	local availableProperties = Instances[object.ClassName]
	for _, propertyData in (availableProperties) do
		local property, propertyType, default = unpack(propertyData)
		if object[property] == default then continue end
		node.Properties[property] = WriteValue(object[property], propertyType, `property`)
	end
	
	for attribute, value in (object:GetAttributes()) do
		if attribute:sub(1, 3) == `RBX` then continue end
		node.Attributes[attribute] = WriteValue(value, nil, `attribute`)
	end
	
	for _, child in (object:GetChildren()) do
		local childNode = Write.Instance(child)
		if childNode == nil then continue end
		table.insert(node.Children, childNode)
	end
	
	return node
end

function Write.Map(map: Instance)
	RootObject = map:Clone()
	local nodeTree = Write.Instance(RootObject, true)
	if FeatureCheck(`NodeTree`) then
		local previous = workspace:FindFirstChild(`Node Tree`)
		if previous and previous:IsA(`ModuleScript`) then
			previous:Destroy()
		end
		
		local ms = Instance.new(`ModuleScript`)
		ScriptEditorService:UpdateSourceAsync(ms, function()
			return `return {NodeTreeVisualizer(nodeTree)}`
		end)
		ms.Name = `Node Tree`
		ms.Parent = workspace
		ScriptEditorService:OpenScriptDocumentAsync(ms)
	end
	
	nodeTree = HttpService:JSONEncode(RootNode)
	
	local nodeTreeBuffer = buffer.fromstring(nodeTree)
	local compressedNodeTree = EncodingService:Base64Encode(
		EncodingService:CompressBuffer(nodeTreeBuffer, Enum.CompressionAlgorithm.Zstd)
	)
	
	local compressedString = buffer.readstring(compressedNodeTree, 0, buffer.len(compressedNodeTree))
	if FeatureCheck(`Debug`) then
		print(`=== Compression Stats ===`)
		print(`Before Compression: {#nodeTree * 0.001}K`)
		print(`After Compression: {#compressedString * 0.001}K`)
	end
	
	RootNode = nil
	RootObject:Destroy()
	RootObject = nil
	return compressedString
end

return Write