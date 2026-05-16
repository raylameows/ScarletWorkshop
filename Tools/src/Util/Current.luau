local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Traverse = require(`./Traverse`)
local Maps = Traverse(`ServerStorage.Maps`)

local Current = {}

function Current:Fetch(): ObjectValue
	local current: ObjectValue? = Maps:FindFirstChild(`Current`)
	if not current then
		current = Instance.new(`ObjectValue`)
		current.Name = `Current`
		current.Value = nil
		current.Parent = Maps
	end

	return current
end

function Current:Set(set: Instance?): Instance?
	local current = self:Fetch()
	current.Value = set
	return set
end

function Current:Get(): Instance?
	local current = self:Fetch()
	return current.Value
end

return Current