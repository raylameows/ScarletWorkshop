return function(path: string): Instance
	local iterate = string.split(path, `.`)
	local current = game
	for index, traverse in (iterate) do
		local found = current:FindFirstChild(traverse)
		if not found then
			found = Instance.new(`Folder`)
			found.Name = traverse
			found.Parent = current
		end
		
		current = found
	end
	
	return current
end