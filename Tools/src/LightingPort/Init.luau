local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local Create = require(`../Util/UI/Create`)
local Frame = require(`../Util/UI/Frame`)
local Label = require(`../Util/UI/Label`)
local Button = require(`../Util/UI/Button`)
local Seperator = require(`../Util/UI/Seperator`)

local Current = require(`../Util/Current`)
local Instances = require(`../Serializer/Instances`)
local TypeToValueBase = require(`../Util/TypeToValueBase`)

local LightingPort = {}
LightingPort.Name = `Lighting Port` :: string
LightingPort.Description = `Allows you to easily preview props in studio` :: string
LightingPort.Icon = 96681177725941 :: number

local function IsLightingEffect(object: Instance)
	return object:IsA(`PostEffect`) or object:IsA(`Atmosphere`) or object:IsA(`Sky`)
end

function LightingPort:Export()
	local current = Current:Get()
	if not current then return end
	
	local previous = current:FindFirstChild(`Lighting`)
	if previous then previous:Destroy() end
	
	local lightingFolder = Instance.new(`Folder`)
	lightingFolder.Name = `Lighting`

	local properties = Instance.new(`Folder`)
	properties.Name = `Properties`
	properties.Parent = lightingFolder

	local effects = Instance.new(`Folder`)
	effects.Name = `Effects`
	effects.Parent = lightingFolder
	
	for _, propertyData in (Instances.Lighting) do
		local property, propertyType, default = unpack(propertyData)
		local class = TypeToValueBase(propertyType)
		if not class then
			warn(`Can't convert {property}'s type {propertyType} to value base`)
			continue
		end
		
		local object: ValueBase = Instance.new(class)
		object.Value = Lighting[property]
		object.Name = property
		object.Parent = properties
	end
	
	for _, effect in (Lighting:GetChildren()) do
		if not IsLightingEffect(effect) then continue end 
		
		local copy = effect:Clone()
		copy.Parent = effects
	end
	
	lightingFolder.Parent = current
end

function LightingPort:Import()
	local current = Current:Get()
	if not current then return end
	
	local lightingFolder = current:FindFirstChild(`Lighting`)
	if not lightingFolder then return end
	
	for _, effect in (Lighting:GetChildren()) do
		if not IsLightingEffect(effect) then continue end
		effect:Destroy()
	end
	
	for _, lightingPropertyObject in (lightingFolder.Properties:GetChildren()) do
		local property, value = lightingPropertyObject.Name, lightingPropertyObject.Value
		Lighting[property] = value
	end
	
	if lightingFolder:FindFirstChild(`Effects`) then
		for _, effect in (lightingFolder.Effects:GetChildren()) do
			local copy = effect:Clone()
			copy.Parent = Lighting
		end
	else
		for _, effect in (lightingFolder:GetChildren()) do
			if not IsLightingEffect(effect) then continue end
			
			local copy = effect:Clone()
			copy.Parent = Lighting
		end
	end
end

function LightingPort:Clear()
	for _, effect in (Lighting:GetChildren()) do
		if not IsLightingEffect(effect) then continue end
		effect:Destroy()
	end
	
	local defaultsFolder = Lighting:FindFirstChild(`EditingLighting`)
	for _, propertyData in (Instances.Lighting) do
		local property, propertyType, default = unpack(propertyData)
		local set = defaultsFolder and defaultsFolder.Properties:FindFirstChild(property) and defaultsFolder.Properties[property].Value or default
		Lighting[property] = set
	end
	
	if defaultsFolder then
		for _, effect in (defaultsFolder.Effects:GetChildren()) do
			local copy = effect:Clone()
			copy.Parent = Lighting
		end
	end
end

function LightingPort:Activate()
	self.UI = Create "ScreenGui" {
		IgnoreGuiInset = true,

		Parent = CoreGui,
		Children = {
			Button {
				Text = `Export`,
				Size = UDim2.fromOffset(200, 30),
				Position = UDim2.fromOffset(50, 50),

				Activated = function()
					self:Export()
				end,
			},
			Button {
				Text = `Import`,
				Size = UDim2.fromOffset(200, 30),
				Position = UDim2.fromOffset(270, 50),

				Activated = function()
					self:Import()
				end,
			},
			Button {
				Text = `Clear`,
				Size = UDim2.fromOffset(200, 30),
				Position = UDim2.fromOffset(490, 50),

				Activated = function()
					self:Clear()
				end,
			},
		}
	}
end

function LightingPort:Deactivate()
	if self.UI then
		self.UI:Destroy()
		self.UI = nil
	end
end

return LightingPort