Table = {}

Table.hasValue = function(table, value)
	for _, v in pairs(table) do
		if v == value then
			return true
		end
	end
	return false
end


Table.hasKey = function(table, key)
	return table[key] ~= nil
end


Table.getEmbeddedValue = function(table, path)
	for _, key in pairs(path) do
		if not Table.hasKey(table, key) then return nil end
		table = table[key]
	end

	return table --TODO explanation variable instead?
end

Table.merge = function(table1, table2)
	local merged = {}

	for key, value in pairs(table1) do
		merged[key] = value
	end

	for key, value in pairs(table2) do
		merged[key] = value
	end

	return merged
end

Table.appendTables = function(table1, table2)
	local newTable = {}

	for _, value in ipairs(table1) do
		table.insert(newTable, value)
	end

	for _, value in ipairs(table2) do
		table.insert(newTable, value)
	end

	return newTable
end

Table.traversePath = function(data, path)
	local current = data
	for _, key in ipairs(path) do
		if type(current) == "table" and current[key] ~= nil then
			current = current[key]
		else
			return nil
		end
	end
	return current
end

return Table
