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

return File
