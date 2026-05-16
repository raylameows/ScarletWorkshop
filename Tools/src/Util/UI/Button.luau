local Create = require(`./Create`)
local Wrapper = require(`./Wrapper`)
local Pseudo = require(`./Pseudo`)

local Defaults = {
	Font = Enum.Font.FredokaOne,
	BackgroundTransparency = 0.5,
	TextScaled = true,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),

	Children = {
		UICorner = Pseudo "UICorner" {
			CornerRadius = UDim.new(0, 7)
		}
	}
}

return Wrapper "TextButton" (Defaults) :: Create.Wrapped<keyof<typeof(Defaults)>>