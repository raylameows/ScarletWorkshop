local Shared = {}

export type Node = {
	Class: string,
	Object: Instance?,
	Properties: {
		[string]: any
	},
	Attributes: {
		[string]: any
	},
	Children: {
		[number]: Node
	},
	Config: {
		[string]: any
	}?
}

return Shared