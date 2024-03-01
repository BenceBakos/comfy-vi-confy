NvimFindConfig = {}

NvimFindConfig.init = function(NvimFind)
	NvimFind.height = 20

	NvimFind.width = 100

	-- list of ignore globs for the filename filter
	-- e.g. "*.png" will ignore any file ending in .png and
	-- "*node_modules*" ignores any path containing node_modules
	NvimFind.files.ignore = { "*.png", "*.pdf", "*.jpg", "*.jpeg", "*.webp" }

	-- start with all result groups collapsed
	NvimFind.search.start_closed = false
end

return NvimFindConfig
