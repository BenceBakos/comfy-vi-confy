require('globals')

Main = require("main")

Main.init({
	'env',
	'base',
	'treesitter',
	'fuzzy',
	'hop',
	'comment',
	'git',
	'spell',
	'lsp',
	'lua',
	'web',
	'php',
	'bash',
	'docker',
	'nix',
	'yaml',
	'xml',
	'git',
	-- rethink cmp, get snippets
	-- 'dap', TODO
	-- note tab open fast
	-- treesitter advanced setup: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#incremental-selection
	-- file managger as text buffer
	-- handle missing binaries, optional depdendencies(in case of fuzzy)
	-- premade macros
	-- https://www.josean.com/posts/nvim-treesitter-and-textobjects
	--  - incremental_selection for treesitter
	--  - textobject aware selection for treesitter
	--
	-- rest of the plugins
	-- treesitter based lsp replacement? treesitter does one file, but I could map all files?
})
