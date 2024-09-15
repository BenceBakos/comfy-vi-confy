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


