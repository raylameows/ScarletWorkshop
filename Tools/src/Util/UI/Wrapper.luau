local Create = require(`./Create`)

return function(class: Create.Class)
	return function(defaults: Create.Properties)
		return function(properties: Create.Properties)
			for k, v in (defaults) do
				if properties[k] then 
					if k == `Children` then
						for _, child in (v) do
							table.insert(properties.Children, child)
						end
					end
					
					continue 
				end
				properties[k] = v
			end
			
			return Create (class) (properties)
		end
	end
end