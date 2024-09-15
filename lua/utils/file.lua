require('io')

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

File.get_intelephense_license = function ()
    local f = assert(io.open(os.getenv("HOME") .. "/intelephense/license.txt", "rb"))
    local content = f:read("*a")
    f:close()
    return string.gsub(content, "%s+", "")
end

File.list = function (path)
	items = vim.split(io.popen('ls '..path..' -1v'):read("*a"),'\n')
	return vim.tbl_filter(function(item) return item ~= "" end, items )
end

return File
