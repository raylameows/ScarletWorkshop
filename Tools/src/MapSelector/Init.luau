local CoreGui = game:GetService("CoreGui")
local Selection = game:GetService("Selection")

local Create = require(`../Util/UI/Create`)
local Frame = require(`../Util/UI/Frame`)
local Label = require(`../Util/UI/Label`)
local Button = require(`../Util/UI/Button`)
local Seperator = require(`../Util/UI/Seperator`)

local Current = require(`../Util/Current`)
local Traverse = require(`../Util/Traverse`)

local MapSelector = {}
MapSelector.Name = `Map Selector` :: string
MapSelector.Description = `Searches through all available maps in the place and allows you to select all editables` :: string
MapSelector.Icon = 117093940689396 :: number

local Maps = Traverse(`ServerStorage.Maps`)
if Maps:FindFirstChild(`PvP`) then Maps = Maps.PvP :: Instance end

function MapSelector:Show()
	if not self.Selected then return end
	self.Selected.Parent = workspace
end

function MapSelector:Hide()
	if not self.Selected then return end
	self.Selected.Parent = Maps
end

function MapSelector:Select(newMap: Folder?)
	self:Hide()
	self.Selected = Current:Set(newMap)
	self:Refresh()
	self:Show()
end

function MapSelector:Refresh()
	for index, button in (self.MapList:GetChildren()) do
		if not button:IsA(`TextButton`) then continue end
		
		if button.Map.Value == self.Selected then
			button.BackgroundColor3 = Color3.new(1, 1, 1)
		else
			button.BackgroundColor3 = Color3.new(0, 0, 0)
		end
	end
end

function MapSelector:Add(map: Instance)
	if not map or not map:IsA(`Folder`) then return end

	Button {
		Text = map.Name,
		Size = UDim2.new(1, 0, 0, 30),
		Parent = self.MapList,
		BackgroundTransparency = 0.75,

		Children = {
			Create "UITextSizeConstraint" {
				MaxTextSize = 17
			},
			Create "ObjectValue" {
				Name = `Map`,
				Value = map
			}
		},

		Activated = function()
			if map == self.Selected then
				self:Select(nil)
			else
				self:Select(map)
			end
		end
	}
end

function MapSelector:ToggleAddButton(visible: boolean)
	if self.AddButton.Visible ~= visible then
		self.AddButton.Visible = visible
	end
end

function MapSelector:UpdateAddButton()
	local selected = Selection:Get()
	if #selected > 1 or #selected == 0 or (selected[1] and (self.Selected == selected[1] or selected[1].Parent == Maps) or not selected[1]:IsA(`Folder`)) then 
		self:ToggleAddButton(false)
	else
		self:ToggleAddButton(true)
	end
end

function MapSelector:List()
	for _, button in (self.MapList:QueryDescendants(`>TextButton`)) do
		button:Destroy()
	end
	
	local maps = Maps:GetChildren()
	if #maps == 0 and not self.Selected then
		for _, possibleMap in (workspace:QueryDescendants(`>Folder`)) do
			self:Add(possibleMap)
		end
	else
		for _, map in (maps) do
			self:Add(map)
		end
		self:Add(self.Selected)
	end
	self:Refresh()
end

function MapSelector:Activate()
	self.Selected = Current:Get()
	self.MapList = Create "ScrollingFrame" {
		Size = UDim2.new(1, 0, 1, -32),
		Position = UDim2.new(0, 0, 0, 32),
		BackgroundTransparency = 1,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BottomImage = "rbxassetid://132155327",
		TopImage = "rbxassetid://132155327",
		BorderSizePixel = 0,
		ScrollBarThickness = 5,
		Children = {
			Create "UIListLayout" {
				Padding = UDim.new(0, 1)
			}
		}
	}
	self.AddButton = Button {
		Text = `Add`,

		Size = UDim2.fromOffset(200, 30),
		Position = UDim2.fromOffset(270, 50),

		Activated = function()
			local map = Selection:Get()[1]
			Selection:Set({})
			map.Parent = Maps
		end,
	}
	
	self.SelectionEvent = Selection.SelectionChanged:Connect(function()
		self:UpdateAddButton()
	end)
	self:UpdateAddButton()
	self:List()

	self.AddedEvent = Maps.ChildAdded:Connect(function()
		self:List()
	end)
	self.RemovedEvent = Maps.ChildRemoved:Connect(function()
		self:List()
	end)
	
	self.UI = Create "ScreenGui" {
		IgnoreGuiInset = true,

		Parent = CoreGui,
		Children = {
			Frame {
				Size = UDim2.new(0, 200, 1, -100),
				Position = UDim2.fromOffset(50, 50),

				Children = {
					Label {
						Text = `Maps`,
						Size = UDim2.new(1, 0, 0, 30)
					},
					Seperator {
						Position = UDim2.new(0, 0, 0, 30)
					},
					self.MapList,
				}
			},
			self.AddButton
		}
	}
end

function MapSelector:Deactivate()
	if self.UI then
		self.UI:Destroy()
		self.UI = nil
	end

	if self.SelectionEvent then
		self.SelectionEvent:Disconnect()
		self.SelectionEvent = nil
	end

	if self.AddedEvent then
		self.AddedEvent:Disconnect()
		self.AddedEvent = nil
	end

	if self.RemovedEvent then
		self.RemovedEvent:Disconnect()
		self.RemovedEvent = nil
	end
end

return MapSelector