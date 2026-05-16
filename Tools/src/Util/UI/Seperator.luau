local Create = require(`./Create`)
local Wrapper = require(`./Wrapper`)
local Pseudo = require(`./Pseudo`)

local Defaults = {
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 0,
	Size = UDim2.new(1, 0, 0, 2),
	BorderSizePixel = 0
}

return Wrapper "Frame" (Defaults) :: Create.Wrapped<keyof<typeof(Defaults)>>