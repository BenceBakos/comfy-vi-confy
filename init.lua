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
	'oil',
	'macro',
	'theme',
	'refactor',
	'abz',
	-- where to store snippets, refactors, spells?
	-- refactors -> treesitter based, low-code definitions
	-- gitlab cli or gitlab nvim plugin
	-- rethink cmp, get snippets
	-- 'dap', TODO
	-- handle missing binaries, optional depdendencies(in case of fuzzy)
	-- premade macros
	-- treesitter advanced setup: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#incremental-selection
	-- https://www.josean.com/posts/nvim-treesitter-and-textobjects
	--  - incremental_selection for treesitter
	--  - textobject aware selection for treesitter
	--
	-- treesitter based lsp replacement? treesitter does one file, but I could map all files?
	-- gpt prompt(bash)
})
