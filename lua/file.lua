File = {}

File.fileExists = function(file)
	-- some error codes:
	-- 13 : EACCES - Permission denied
	-- 17 : EEXIST - File exists
	-- 20	: ENOTDIR - Not a directory
	-- 21	: EISDIR - Is a directory
	--
	local isok, errstr, errcode = os.rename(file, file)
	if isok == nil then
		if errcode == 13 then
			-- Permission denied, but it exists
			return true
		end
		return false
	end
	return true
end

return File
