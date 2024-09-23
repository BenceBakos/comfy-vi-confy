Terminal = require("utils.terminal")
Package = require("utils.package")

Fuzzy = {}

Fuzzy.excludeOs = {
	Terminal.TERMUX
}

Fuzzy.dependencyBinaries = {
	debian = { 'fz' },
	arch = { 'fz' }
}

Fuzzy.packages = {
	'bencebakos/nvim-find'
}

Fuzzy.nvimFind = nil

Fuzzy.init = function()
	local nvimFindConfig = Package.want("nvim-find.config")
	Fuzzy.nvimFind = Package.want("nvim-find.defaults")

	if not Fuzzy.nvimFind or not nvimFindConfig then return false end

	nvimFindConfig.height = 20
	nvimFindConfig.width = 100

	-- list of ignore globs for the filename filter
	-- e.g. "*.png" will ignore any file ending in .png and
	-- "*node_modules*" ignores any path containing node_modules
	nvimFindConfig.files.ignore = { "*.png", "*.pdf", "*.jpg", "*.jpeg", "*.webp" }

	-- start with all result groups collapsed
	nvimFindConfig.search.start_closed = false
end

Fuzzy.mapFunctions = {
	{
		mode = 'n',
		map = '<Leader>c',
		to = function()
			if not Fuzzy.nvimFind then return nil end
			Fuzzy.nvimFind.files()
		end
	}
}


return Fuzzy
