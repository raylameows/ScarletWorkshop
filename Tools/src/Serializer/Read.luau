local AssetService = game:GetService("AssetService")
local EncodingService = game:GetService("EncodingService")
local HttpService = game:GetService("HttpService")

local Shared = require(`./Shared`)
local Instances = require(`./Instances`)
local Traverse = require(`../Util/Traverse`)
local SafeCall = require(`../Util/SafeCall`)

local Read = {}
local RootNode: Shared.Node?

local function ReadValue(value: any, valueType: string, propOrAtt: string?)
	local valueType = valueType or typeof(value)
	local call = Read[valueType]
	if not call then
		warn(`Type {valueType} of {propOrAtt and `{propOrAtt} ` or ``}{value} cannot be read`)
		return
	end

	return call(value)
end

function Read.string(input: string)
	return input
end

function Read.number(number: number)
	return number
end

function Read.boolean(bool: boolean)
	return bool
end

function Read.Color3(color: {number})
	return Color3.new(unpack(color))
end

function Read.Vector3(vector: {number})
	return Vector3.new(unpack(vector))
end

function Read.CFrame(cf: {number})
	return CFrame.new(unpack(cf))
end

function Read.UDim2(udim: {number})
	return UDim2.new(unpack(udim))
end

function Read.EnumItem(enumItem: string)
	local enumName, enumType, enumItem = unpack(string.split(enumItem, `.`))
	if not enumName or not enumType or not enumItem or enumName ~= `Enum` then
		warn(`Invalid EnumItem string {enumItem}`)
		return
	end

	return Enum[enumType][enumItem]
end


function Read.BrickColor(color: number)
	return BrickColor.new(color)
end

function Read.NumberSequence(seq: {[number]: {[string]: any}})
	local keypoints = {}
	for _, k in (seq) do
		table.insert(keypoints, NumberSequenceKeypoint.new(k.Time, k.Value, k.Envelope))
	end

	return NumberSequence.new(keypoints)
end

function Read.ColorSequence(seq: {[number]: {[string]: any}})
	local keypoints = {}
	for _, k in (seq) do
		table.insert(keypoints, ColorSequenceKeypoint.new(k.Time, Read.Color3(k.Color)))
	end

	return ColorSequence.new(keypoints)
end

function Read.NumberRange(range: {number})
	return NumberRange.new(unpack(range))
end

function Read.Rect(rect: {number})
	local min = Vector2.new(rect[1], rect[2])
	local max = Vector2.new(rect[3], rect[4])
	return Rect.new(min, max)
end

function Read.UDim(udim: {number})
	return UDim.new(unpack(udim))
end

function Read.Vector2(vector)
	return Vector2.new(unpack(vector))
end

function Read.Mesh(id: string)
	local cache = Traverse(`ReplicatedStorage.Assets.MeshCache`)
	local mesh: MeshPart? = cache:FindFirstChild(id)
	local skipProperties = {MeshId = true}
	if mesh then
		mesh = mesh:Clone()
	else
		local success, err = pcall(function()
			mesh = AssetService:CreateMeshPartAsync(Content.fromUri(id))
		end)
		
		if success then
			mesh.Name = id
			mesh.Parent = cache
			mesh = mesh:Clone()
		else
			warn(`Mesh fetch error {err}`)
			mesh = Instance.new(`Part`)
			skipProperties.TextureID = true
		end
	end
	
	return mesh, skipProperties
end

function Read.InstanceReference(node: Shared.Node, property: string)
	if node == nil or node.Properties[property] == nil then return end
	
	local path = string.split(node.Properties[property], `.`)
	local current = RootNode
	for _, move in (path) do
		current = current.Children[tonumber(move)]
	end
	
	repeat task.wait() until current.Object
	node.Object[property] = current.Object
	return
end

function Read.Instance(node: Shared.Node, direct: boolean)
	if not Instances[node.Class] then
		warn(`Unknown node with name {node.Properties.Name} of class {node.Class} will not be read`)
		return
	end
	
	local object: Instance?
	local skipProperties: {[string]: boolean} = {}
	if node.Class == `MeshPart` and node.Properties.MeshId and node.Properties.MeshId ~= `` then
		object, skipProperties = Read.Mesh(node.Properties.MeshId)
	else
		object = Instance.new(node.Class)
	end
	
	local availableProperties = Instances[object.ClassName]
	for _, propertyData in (availableProperties) do
		local property, propertyType, default = unpack(propertyData)
		if skipProperties[property] then continue end
		
		if propertyType == `InstanceReference` then
			task.spawn(Read.InstanceReference, node, property)
		else
			object[property] = node.Properties[property] == nil and default or ReadValue(node.Properties[property], propertyType, `property`)
		end
	end
	
	for attribute, value in (node.Attributes) do
		object:SetAttribute(attribute, ReadValue(value, nil, `attribute`))
	end
	
	for _, childNode in (node.Children) do
		local child = Read.Instance(childNode)
		if child == nil then continue end
		child.Parent = object
	end
	
	node.Object = object
	return object
end

function Read.Map(code: string)
	if string.sub(code, 1, 8) == `https://` then
		code = HttpService:GetAsync(code)
	end
	
	local compressedNodeTree = buffer.fromstring(code)
	local nodeTreeBuffer = EncodingService:DecompressBuffer(
		EncodingService:Base64Decode(compressedNodeTree), Enum.CompressionAlgorithm.Zstd
	)
	
	local clearCode = buffer.readstring(nodeTreeBuffer, 0, buffer.len(nodeTreeBuffer))
	local nodeTree = HttpService:JSONDecode(clearCode)
	
	RootNode = nodeTree
	local map = Read.Instance(nodeTree)
	return map
end

return Read