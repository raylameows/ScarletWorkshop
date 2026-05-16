return function<T>(func: () -> T): (T?, any)
	local success, result = pcall(func)

	if success then
		return result, nil
	else
		return nil, result
	end
end