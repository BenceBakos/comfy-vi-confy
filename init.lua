
require('globals')

Main = require("main")

Main.init({
	'env',
	'base',
	'treesitter',
	'fuzzy',
	'hop',
	-- 'ide',
	--IDE or separate it? Get the most out, smallest possible layers, and one shall not depend on the other
	-- git tab open fast (lazygit, or just terminal)
	-- note tab open fast
	-- treesitter advanced setup: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#incremental-selection
	-- file managger as text buffer
	-- handle missing binaries, optional depdendencies(in case of fuzzy)
})
