local Create = require(`./Create`)
local Wrapper = require(`./Wrapper`)

return Wrapper "TextLabel" {
	Font = Enum.Font.FredokaOne,
	BackgroundTransparency = 1,
	TextScaled = true,
	TextColor3 = Color3.fromRGB(255, 255, 255),
}