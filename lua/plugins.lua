Plugins = {}

Plugins.init = function(Package)
	-- Packages
	Package.install({
		'williamboman/mason.nvim',
		"williamboman/mason-lspConfig.nvim",
		'neovim/nvim-lspconfig',
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'L3MON4D3/LuaSnip',
		'hrsh7th/nvim-cmp',
		'rafamadriz/friendly-snippets',
		'natecraddock/nvim-find',
		'saadparwaiz1/cmp_luasnip',
		'mfussenegger/nvim-dap',
		'aklt/plantuml-syntax',
		'weirongxu/plantuml-previewer.vim',
		'f-person/git-blame.nvim',
		'nvim-lua/plenary.nvim',
		'stevearc/dressing.nvim',
		'smoka7/hop.nvim',
		'nvim-treesitter/nvim-treesitter',
		'numToStr/Comment.nvim',
		'preservim/tagbar'
	})

	Treesitter = require('nvim-treesitter.configs')
	require('plugins.treesitter').init(Treesitter)

	-- LSP server, DAP server installer
	Mason = require("mason")
	require('plugins.mason').init(Mason)

	-- Autoinstall LSP, DAP servers
	MasonLsp = require("mason-lspconfig")
	require('plugins.masonlsp').init(MasonLsp)

	-- Hop
	Hop = require('hop')
	require('plugins.hop').init(Hop)

	-- LuaSnip
	LuaSnip = require('luasnip')
	require('plugins.luasnip').init(LuaSnip)

	-- Cmp
	Cmp = require('cmp')
	require('plugins.cmp').init(Cmp, LuaSnip)

	-- Cmp lsp configs
	CmpLsp = require('cmp_nvim_lsp')

	-- LSP & autocomplete
	LspConfig = require('lspconfig')
	require('plugins.lspconfig').init(LspConfig, CmpLsp)

	-- DAP (needs mason install after config)
	local Dap = require('dap')
	require('plugins.dap').init(Dap)

	-- fuzzy finder
	local NvimFind = require("nvim-find.config")
	require('plugins.nvimfind').init(NvimFind)

	-- comment 
	local Comment = require('Comment')
	require('plugins.comment').init(Comment)
end

return Plugins
