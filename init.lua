
-- Todo:
-- finish outsourvce
-- treesitter possible configs
-- other good plugins


-- DEPENDENCIES
-- git
-- fd
-- ripgrep
-- xclip
-- cargo
-- node
-- php
-- composer
-- tree-sitter
-- phpactor (https://phpactor.readthedocs.io/en/master/usage/standalone.html#global-installation)

Log = require("utils.log")
File = require("utils.file")
Keyboard = require("utils.keyborad")
Terminal = require("utils.terminal")
Package = require("utils.packages")

AutoCommands = require("autocommands")
Mappings = require("mappings")
Commands = require("commands")
Options = require("options")

-- globals
DEBUGGERBASE = "/home/b/vscode-php-debug/"
PHPDAPSERVERROOT = "/var/www/html/"

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
	'tyru/open-browser.vim',
	'aklt/plantuml-syntax',
	'weirongxu/plantuml-previewer.vim',
	'f-person/git-blame.nvim',
	'nvim-lua/plenary.nvim',
	'stevearc/dressing.nvim',
	'akinsho/flutter-tools.nvim',
	'smoka7/hop.nvim',
	'nvim-treesitter/nvim-treesitter'
})

-- capslock to escape in x
-- unod setxkbmap :
--    setxkbmap -option
Terminal.run('setxkbmap -option caps:escape')
-- gnome solution: gnome-tweaks package

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
require('plugins.cmp').init(Cmp,LuaSnip)

-- Cmp lsp configs
CmpLsp = require('cmp_nvim_lsp')

-- LSP & autocomplete
LspConfig = require('lspconfig')
require('plugins.lspconfig').init(LspConfig,CmpLsp)

-- Flutter
Flutter = require("flutter-tools")
require("plugins.flutter").init(Flutter)

-- DAP (needs mason install after config)
local Dap = require('dap')
require('plugins.dap').init(Dap)

-- fuzzy finder
local NvimFind = require("nvim-find.config")
require('plugins.nvimfind').init(NvimFind)

Options.init()

Commands.init(Keyboard)

AutoCommands.init()

Mappings.init(Hop,Keyboard,Log)


