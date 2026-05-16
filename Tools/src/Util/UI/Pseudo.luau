local Create = require(`./Create`)

return function(class: Create.Class)
	return function(properties: Create.Properties)
		return {class, properties}
	end
end