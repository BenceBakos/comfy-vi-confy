Table = {}

Table.hasValue = function(table,value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end


Table.hasKey = function(table,key)
	return table[key] ~= nil
end


Table.hasEmbeddedKey = function(table,keys)
	for _,key in pairs(keys) do
		if not Table.hasKey(table,key) then return false end
		table = table[key]
	end

	return true
end


Table.getEmbeddedValue = function(table,path)
	for _,key in pairs(path) do
		if not Table.hasKey(table,key) then return nil end
		table = table[key]
	end

	return table --TODO explanation variable instead?
end

return Table

