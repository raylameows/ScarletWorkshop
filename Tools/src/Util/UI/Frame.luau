local Create = require(`./Create`)
local Wrapper = require(`./Wrapper`)
local Pseudo = require(`./Pseudo`)

local Defaults = {
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BackgroundTransparency = 0.5,
	BorderSizePixel = 0,
	
	Children = {
		UICorner = Pseudo "UICorner" {
			CornerRadius = UDim.new(0, 7)
		}
	}
}

return Wrapper "Frame" (Defaults) :: Create.Wrapped<keyof<typeof(Defaults)>>