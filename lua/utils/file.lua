require('io')

File = {}

File.fileExists = function(file)
	local home = require('os').getenv('HOME')

	local f = io.open(file:gsub('~', home), "r")
	if f ~= nil then
		io.close(f)
		return true
	else return false end
end

File.get_intelephense_license = function()
	local f = assert(io.open(os.getenv("HOME") .. "/intelephense/license.txt", "rb"))
	local content = f:read("*a")
	f:close()
	return string.gsub(content, "%s+", "")
end

File.list = function(path)
	local items = vim.split(io.popen('ls ' .. path .. ' -1v'):read("*a"), '\n')
	return vim.tbl_filter(function(item) return item ~= "" end, items)
end

File.readAll = function(path)
	local file = io.open(path, "r")

	if not file then return nil end

	local content = file:read("*all")

	file:close()

	return content
end

File.getPersistnecyPath = function()
	if Terminal.getOs() == Terminal.TERMUX then
		return os.getenv("HOME") .. '/storage/shared/nvim/'
	end

	return os.getenv("HOME") .. '/nvim/'
end

File.storeTable = function(table, path)
	local json_data = vim.fn.json_encode(table)

	local file = io.open(path, "w")
	if not file then
		error("Could not open file for writing: " .. path)
	end

	file:write(json_data)
	file:close()
end


File.loadTable = function(path)
    local file = io.open(path, "r")
    if not file then
        error("Could not open file for reading: " .. path)
    end

    local json_data = file:read("*a")
    file:close()

    return vim.fn.json_decode(json_data)
end

return File
