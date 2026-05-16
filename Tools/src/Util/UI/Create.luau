export type Class = string
export type Properties = {[string]: any}
export type Call = (class: Class) -> ((properties: Properties) -> Instance)
export type Wrapped<Defaults> = (properties: {[Defaults]: any}) -> Instance

local Create
Create = function(class: Class)
	return function(properties: Properties)
		local object: Instance = Instance.new(class)
		local parent: Instance?
		
		for k, v in (properties) do
			if k == `Parent` then
				parent = v
			elseif k == `Children` then
				for _, child in (v) do
					if typeof(child) == `table` then
						Create (child[1]) (child[2]).Parent = object
					else
						child.Parent = object
					end
				end
			else
				if typeof(v) == `function` then
					object[k]:Connect(v)
				else
					object[k] = v
				end
			end
		end
		
		if parent then
			object.Parent = parent
		end
		
		return object
	end
end

return Create