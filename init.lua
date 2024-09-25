
require('globals')

Main = require("main")

Main.init({
	'env',
	'base',
	'treesitter',
	'fuzzy',
	'hop',
	'comment',
	'lsp',
	'lua',
	'web',
	'php',
	'bash',
	'docker',
	'nix',
	'yaml',
	'xml',
	-- rethink cmp, get snippets
	-- git tab open fast (lazygit, or just terminal)
	-- note tab open fast
	-- treesitter advanced setup: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#incremental-selection
	-- file managger as text buffer
	-- handle missing binaries, optional depdendencies(in case of fuzzy)
	-- understand fixlists
	-- premade macros
	-- understand clipboards
	-- get list of todos in code(just a fixlist)
	-- refactor if not Fuzzy.nvimFind or not nvimFindConfig then return false end lines for less repetition -> Package->setupPackage, also make log when package not found
	-- treesitter based lsp replacement? treesitter does one file, but I could map all files?
	-- https://www.josean.com/posts/nvim-treesitter-and-textobjects
	-- incremental_selection for treesitter
	-- textobject aware selection for treesitter
})
