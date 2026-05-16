local CoreGui = game:GetService("CoreGui")

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
if Maps:FindFirstChild(`PvP`) then Maps = Maps.PvP end

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
	
	for index, map in (Maps:GetChildren()) do
		self:Add(map)
	end
	self:Add(self.Selected)
	self:Refresh()
	
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
			}
		}
	}
end

function MapSelector:Deactivate()
	if self.UI then
		self.UI:Destroy()
		self.UI = nil
	end
end

return MapSelector