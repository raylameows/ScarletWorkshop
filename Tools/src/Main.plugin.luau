local PluginDebugService = game:GetService("PluginDebugService")
local RunService = game:GetService("RunService")
local Selection = game:GetService("Selection")
local UserInputService = game:GetService("UserInputService")
if not RunService:IsStudio() then return end

local FeatureCheck = require(`./Util/FeatureCheck`)

local Toolbar: PluginToolbar = plugin:CreateToolbar(`ScarletUtilityTools`)
local Plugins: {Folder} = {} do
	for _,folder in (script.Parent:GetChildren()) do
		if folder:IsA(`Folder`) and folder:FindFirstChild(`Init`) then
			table.insert(Plugins, folder)
		end
	end
end

local Current: {}? = nil
for _, tool in (Plugins) do
	local module = require(tool.Init)
	if not module.Name then continue end
	module.Plugin = plugin
	
	local button = Toolbar:CreateButton(module.Name, module.Description or module.Name, `rbxassetid://{module.Icon}`)
	button.Click:Connect(function()
		if Current then
			local currentIsSame = Current == module
			Deactivation()
			
			if currentIsSame then 
				plugin:Deactivate()
				return
			end
		end
		
		plugin:Activate(true)
		module:Activate()
		Current = module
	end)
end

-- Searching for the plugin inside PluginDebugService is very painful especially because of the icons and the user_ prefix
local quickSelect: RBXScriptConnection?
if FeatureCheck(`Debug`) then
	quickSelect = UserInputService.InputBegan:Connect(function(input: InputObject, gpe: boolean)
		if gpe then return end
		
		if input.KeyCode == Enum.KeyCode.F then
			local object = PluginDebugService:FindFirstChild(`user_ScarletUtilityTools.rbxmx`)
			Selection:Set({object})
		end
	end)
end

function Deactivation()
	if Current then
		Current:Deactivate()
		Current = nil
	end
end

function Unloading()
	if quickSelect then
		quickSelect:Disconnect()
		quickSelect = nil
	end
	Deactivation()
end

plugin.Deactivation:Connect(Deactivation)
plugin.Unloading:Connect(Unloading)