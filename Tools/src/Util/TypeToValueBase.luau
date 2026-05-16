local function Singleton<T>(value: T | ""): T
	return value
end

local TypeToValueBase = {
	boolean = Singleton "BoolValue",
	string = Singleton "StringValue",
	number = Singleton "NumberValue",
	Instance = Singleton "ObjectValue",
	BrickColor = Singleton "BrickColorValue",
	CFrame = Singleton "CFrameValue",
	Color3 = Singleton "Color3Value",
	Vector3 = Singleton "Vector3Value",
}

type InputType = keyof<typeof(TypeToValueBase)>
type ValueBase = index<typeof(TypeToValueBase), InputType>

return function(inputType: InputType): ValueBase
	local class = TypeToValueBase[inputType]
	return class
end