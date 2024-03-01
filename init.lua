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

-- replace all in multilple files
-- 1. :grep <search term>
-- 2. :cdo %s/<search term>/<replace term>/gc
-- 3. (If you want to save the changes in all files) :cdo update

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

-- Packages
Package.install({
	'williamboman/mason.nvim',
	"williamboman/mason-lspconfig.nvim",
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



-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query",'php','json'},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
}


-- LSP server, DAP server installer
require("mason").setup()

-- Autoinstall LSP, DAP servers
require("mason-lspconfig").setup {
	automatic_installation = true
}

-- Snippets
require('luasnip.loaders.from_vscode').lazy_load()

-- Hop
Hop = require('hop')
Hop.setup()

-- LSP & autocomplete
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local cmpLsp = require('cmp_nvim_lsp')
local luaSnip = require('luasnip')

-- Extend cmp capabilities
local lspDefaults = lspconfig.util.default_config

lspDefaults.capabilities = vim.tbl_deep_extend(
	'force',
	lspDefaults.capabilities,
	cmpLsp.default_capabilities()
)

-- Cmp setup
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			luaSnip.lsp_expand(args.body)
		end
	},
	sources = {
		{ name = 'nvim_lsp', keyword_length = 2 },
		{ name = 'path',     keyword_length = 2 },
		{ name = 'buffer',   keyword_length = 2 },
		{ name = 'luasnip',  keyword_length = 2 },
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			local hasWordsBefore = col ~= 0 and
			vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil

			if cmp.visible() then
				cmp.select_next_item()
			elseif hasWordsBefore then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luaSnip.jumpable(-1) then
				luaSnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}
})

-- configure language servers (needs installation with mason after config)
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- https://github.com/williamboman/mason-lspconfig.nvim
-- lspconfig.pylsp.setup({})
-- lspconfig.intelephense.setup({
--    init_options = {
--        licenceKey = File.get_intelephense_license()
--    }
--})
lspconfig.phpactor.setup({
	init_options = {
		["language_server_phpstan.enabled"] = false,
		["language_server_psalm.enabled"] = false,
	},

	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = false
				}
			}
		}
	}
})

local function confirmDone(evt)
  local context = evt.entry.context
  if vim.tbl_contains({'php','lua'},context.filetype) then
    return
  end

  if vim.startswith(context.cursor_after_line, '(') then
    return
  end

  local endRange = evt.entry.source_insert_range['end']
  vim.treesitter.get_parser(context.bufnr):parse({endRange.line, endRange.line})
  local node = vim.treesitter.get_node({pos = {endRange.line, endRange.character - 1}})

  local methodNodeTypes = {'class_constant_access_expression','member_access_expression'}

  if vim.tbl_contains(methodNodeTypes,node:parent():type()) then
	  vim.api.nvim_feedkeys('(', 'i', false)
  end

end

cmp.event:on('confirm_done', confirmDone)


lspconfig.tailwindcss.setup({})
lspconfig.bashls.setup({})
lspconfig.quick_lint_js.setup({})
lspconfig.cssls.setup({})
lspconfig.dockerls.setup({})
lspconfig.lemminx.setup({})
lspconfig.yamlls.setup({})
lspconfig.rnix.setup {}
lspconfig.tsserver.setup {}
lspconfig.jedi_language_server.setup {}

-- Flutter
require("flutter-tools").setup {
}



-- DAP (needs mason install after config)
local dap = require('dap')

-- DAP PHP
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#PHP
-- https://github.com/xdebug/vscode-php-debug#installation
if File.fileExists(DEBUGGERBASE) then
	dap.adapters.php = {
		type = 'executable',
		command = 'node',
		args = { DEBUGGERBASE .. "out/" .. 'phpDebug.js' }
	}

	dap.configurations.php = {
		{
			type = 'php',
			request = 'launch',
			name = 'Listen for Xdebug',
			log = true,
			serverSourceRoot = vim.fn.expand("%:p:h") .. "/",
			localSourceRoot = vim.fn.expand("%:p:h") .. "/"
		}
	}

	--force deleting of debugger buffer
	vim.api.nvim_create_autocmd('BufHidden', {
		pattern  = '[dap-terminal]*',
		callback = function(arg)
			vim.schedule(function() vim.api.nvim_buf_delete(arg.buf, { force = true }) end)
		end
	})
end

-- fuzzy finder
local cfg = require("nvim-find.config")

cfg.height = 20

cfg.width = 100

-- list of ignore globs for the filename filter
-- e.g. "*.png" will ignore any file ending in .png and
-- "*node_modules*" ignores any path containing node_modules
cfg.files.ignore = { "*.png", "*.pdf", "*.jpg", "*.jpeg", "*.webp" }

-- start with all result groups collapsed
cfg.search.start_closed = false

AutoCommands.init()
Mappings.init(Hop,Keyboard)
Commands.init(Keyboard)
Options.init()


