local CoreGui = game:GetService("CoreGui")
local ScriptEditorService = game:GetService("ScriptEditorService")
local Selection = game:GetService("Selection")

local Write = require(`./Write`)
local Read = require(`./Read`)
local Current = require(`../Util/Current`)
local FeatureCheck = require(`../Util/FeatureCheck`)

local Create = require(`../Util/UI/Create`)
local Frame = require(`../Util/UI/Frame`)
local Label = require(`../Util/UI/Label`)
local Button = require(`../Util/UI/Button`)
local TextBox = require(`../Util/UI/TextBox`)

local Serializer = {}
Serializer.Priority = 1
Serializer.Name = `Serializer` :: string
Serializer.Description = `Serializes your map into a string, allowing you to easily test it in-game` :: string
Serializer.Icon = 127938367765919 :: number

function Serializer:Activate()
	local SerializeButton
	local ReadbackInput
	local PreviewButton
	SerializeButton = Button {
		Text = `Serialize`,

		Size = UDim2.fromOffset(200, 30),
		Position = UDim2.fromOffset(50, 50),

		Activated = function()
			local previous = workspace:FindFirstChild(`Scarlet Map Code`)
			if previous and previous:IsA(`Script`) and previous.Disabled then
				previous:Destroy()
			end
			
			local current = Current:Get()
			if not current then return end
			
			local code = Write.Map(current)
			local copy = Instance.new(`Script`)
			copy.Disabled = true
			ScriptEditorService:UpdateSourceAsync(copy, function()
				return code
			end)
			copy.Name = `Scarlet Map Code`
			copy.Parent = workspace
			Selection:Set({copy})
			ScriptEditorService:OpenScriptDocumentAsync(copy)
		end,
	}
	ReadbackInput = TextBox {
		PlaceholderText = `Readback`,

		Size = UDim2.fromOffset(200, 30),
		Position = UDim2.fromOffset(270, 50),

		FocusLost = function(enter: boolean)
			if not enter then return end

			local code = ReadbackInput.Text
			local map = Read.Map(code)
			if not map then return end
			
			map.Parent = workspace
		end,
	}
	PreviewButton = Button {
		Text = `Preview`,
		
		Size = UDim2.fromOffset(200, 30),
		Position = UDim2.new(0, 50, 1, -80),
		
		Activated = function()
			local current = Current:Get()
			if not current then return end
			
			local code = Write.Map(current)
			local map = Read.Map(code)
			if not map then return end
			
			map.Parent = workspace
		end,
	}
	
	self.UI = Create "ScreenGui" {
		IgnoreGuiInset = true,
		
		Parent = CoreGui,
		Children = {
			SerializeButton,
			ReadbackInput,
			FeatureCheck(`Debug`) and PreviewButton or nil,
		}
	}
end

function Serializer:Deactivate()
	if self.UI then
		self.UI:Destroy()
		self.UI = nil
	end
end

return Serializer