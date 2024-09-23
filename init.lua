
require('globals')

Main = require("main")

Main.init({
	'env',
	'base',
	'treesitter',
	'fuzzy'
	-- gracefully handle when package is not installed(require and check for error?)
	-- handle missing binaries
	-- 'ide',
	--IDE or separate it? Get the most out, smallest possible layers, and one shall not depend on the other
	-- git tab open fast (lazygit, or just terminal)
	-- note tab open fast
	-- treesitter advanced setup: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#incremental-selection
})
