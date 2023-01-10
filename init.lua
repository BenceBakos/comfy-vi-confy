Log = require("log")
File = require("file")
Keyboard = require("keyborad")
Terminal = require("terminal")
Package = require("packages")

-- globals
DEBUGGERBASE = "/home/b/debugger/"
PHPDAPSERVERROOT = "/var/www/html/"


-- Packages
Package.install({
	'williamboman/mason.nvim',
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
	'mfussenegger/nvim-dap'
})

-- Package managger functionality
Keyboard.command('PackagesUpdate', ':lua Package.update()', {})
Keyboard.command('PackagesClean', ':lua Package.clean()', {})

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- LSP server, DAP server installer
require("mason").setup()

-- Snippets
require('luasnip.loaders.from_vscode').lazy_load()

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

-- Options enabelsing autocomplete
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Cmp setup
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			luaSnip.lsp_expand(args.body)
		end
	},
	sources = {
		{ name = 'path', keyword_length = 2 },
		{ name = 'nvim_lsp', keyword_length = 2 },
		{ name = 'buffer', keyword_length = 2 },
		{ name = 'luasnip', keyword_length = 2 },
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			local hasWordsBefore =  col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil

			if cmp.visible() then
				cmp.select_next_item()
			elseif luaSnip.expand_or_jumpable() then
				luaSnip.expand_or_jump()
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
lspconfig.sumneko_lua.setup({
	settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
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

lspconfig.pylsp.setup({})
lspconfig.intelephense.setup({})
lspconfig.phpactor.setup({})
lspconfig.bashls.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.quick_lint_js.setup({})


-- LSP bindings
Keyboard.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', false)
Keyboard.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', false)
Keyboard.map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', false)
Keyboard.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', false)
Keyboard.map('n', 'gk', '<cmd>lua vim.lsp.buf.type_definition()<cr>', false)
Keyboard.map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', false)
Keyboard.map('n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<cr>', false)
Keyboard.map('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>', false)
Keyboard.map('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', false)
Keyboard.map('n', 'gof', '<cmd>lua vim.diagnostic.open_float()<cr>', false)
Keyboard.map('n', 'gm', '<cmd>lua vim.diagnostic.goto_prev()<cr>', false)
Keyboard.map('n', 'gM', '<cmd>lua vim.diagnostic.goto_next()<cr>', false)

-- DAP (needs mason install after config)
local dap = require('dap')

-- DAP PHP
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#PHP
-- https://github.com/xdebug/vscode-php-debug#installation
if File.fileExists(DEBUGGERBASE .. "vscode-php-debug/") then
	dap.adapters.php = {
		type = 'executable',
		command = 'node',
		args = { DEBUGGERBASE .. "vscode-php-debug/out/" .. 'phpDebug.js' }
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

-- Dap mappings
Keyboard.map('n', '<Leader>m', ':lua require"dap".toggle_breakpoint()<CR>',false)
Keyboard.map('n', '<Leader>n', ':lua require"dap".continue()<CR>',false)
Keyboard.map('n', '<Leader>i', ':lua require"dap".step_into()<CR>',false)
Keyboard.map('n', '<Leader>o', ':lua require"dap".step_over)<CR>',false)
Keyboard.map('n', '<Leader>s', ':lua require("dap").repl.open({}, "vsplit")<CR>',false)
Keyboard.map('n', '<Leader>p', ':lua require("dap").repl.open({}, "vsplit")<CR><C-w>hi.scopes<CR><Esc>{',false)

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

Keyboard.map('n', '<Leader>c', ':lua require("nvim-find.defaults").files()<cr>')
Keyboard.map('n', '<Leader>b', ':lua require("nvim-find.defaults").buffers()<cr>')
Keyboard.map('n', '<Leader>f', ':lua require("nvim-find.defaults").search()<cr>')
Keyboard.map('n', '<Leader>F', ':lua require("nvim-find.defaults").search_at_cursor()<cr>')

-- cmdline autocomplete setup
vim.opt.wildmode = "longest,full"

-- persistent undo
vim.opt.undofile = true

-- system clipboard
vim.opt.clipboard = "unnamedplus"

-- line numbers
vim.opt.number = true

-- errors into line number column
vim.opt.signcolumn = "number"


-- smart search with / and ?
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignore = '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx'

-- tab size
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.tabpagemax = 2

-- disable mouse
vim.opt.mouse = nil

-- no need to scroll till end/top of screen to move buffer content
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8


-- copy path to clipboard
Keyboard.command('Cgpath', ":let @+=expand('%:p')")
Keyboard.command('Cpath', ":let @+=expand('%')")

-- persistent cursor position
vim.api.nvim_create_autocmd(
	{ 'BufReadPost' }, {
	pattern = { '*' },
	callback = function()
		if (vim.opt_local.filetype:get():match('commit') or vim.opt_local.filetype:get():match('rebase'))
		then return end

		local markpos = vim.api.nvim_buf_get_mark(0, '"')
		if (markpos[1] > 1) and (markpos[1] <= vim.api.nvim_buf_line_count(0)) then
			vim.api.nvim_win_set_cursor(0, { markpos[1], markpos[2] })
			Keyboard.feed("zz", "n")
		end
	end
})

-- force filetypes for extensions
vim.api.nvim_create_autocmd(
	{ 'BufReadPost' }, {
	pattern = { '*.html.twig' },
	callback = function()
		vim.bo.filetype = "html"
	end
})

-- capslock to escape
-- unod setxkbmap :
--    setxkbmap -option
Terminal.run('setxkbmap -option caps:escape')
-- gnome solution: gnome-tweaks package

-- tabs/buffers
Keyboard.map('n', 'th', ':tabfirst<CR>', false)
Keyboard.map('n', 'tj', ':tabnext<CR>', false)
Keyboard.map('n', 'tk', ':tabprev<CR>', false)
Keyboard.map('n', 'tl', ':tablast<CR>', false)
Keyboard.map('n', 'té', ':vsplit<Space>', { noremap = true, silent = false })
Keyboard.map('n', 'tt', ':tabedit<Space>', { noremap = true, silent = false })
Keyboard.map('n', 'td', ':tabclose<CR>', false)
Keyboard.map("n", "ti", ":tabedit<Space><CR>:tab ter<CR>", false)
Keyboard.map("n", "to", ":botright vnew<Space><CR>:tab ter<CR>", false)

Keyboard.mapFunction("n", "tu", function()
	vim.api.nvim_feedkeys(":tabedit " .. vim.fn.getcwd() .. '/', "n", true)
end)

Keyboard.mapFunction("n", "tá", function()
	vim.api.nvim_feedkeys(":vsplit " .. vim.fn.getcwd() .. '/', "n", true)
end)

-- qwertz modes
Keyboard.map("n", "é", "$")
Keyboard.map("v", "é", "$")

-- remove selection
Keyboard.map("n", 'á', ':noh<CR>')

-- close line with semicolon
Keyboard.map('n', ';', '$a;<ESC>')

-- stay in visual mode while indenting
Keyboard.map("v", "<", "<gv")
Keyboard.map("v", ">", ">gv")

-- exit to normal mode from terminal
Keyboard.map("t", "<Esc>", "<C-\\><C-n>")

-- close symbols
Keyboard.map("i", "(", "()<Esc>i")
Keyboard.map("i", "[", "[]<Esc>i")
Keyboard.map("i", "{", "{}<Esc>i")
Keyboard.map("i", "'", "''<Esc>i")
Keyboard.map("i", '"', '""<Esc>i')
Keyboard.map("i", '`', '``<Esc>i')

-- remove surrounding symbols
Keyboard.mapFunction("n", "X", function()
	local char = Keyboard.getCurrentChar()

	for i, _ in pairs(Keyboard.doubleCharactersOpen) do
		local opening = Keyboard.doubleCharactersOpen[i]
		local closing = Keyboard.doubleCharactersClose[i]

		if char == opening
		then Keyboard.feed("di" .. closing .. "va" .. closing .. "p", "n") end

		if char == closing
		then Keyboard.feed("di" .. opening .. "va" .. opening .. "p", "n") end

	end
end)

-- remove double symbols in insert mode
--on a beautifull sunday afternoon...
vim.cmd [[
	inoremap <expr> <bs> Remove_pair()
	imap <c-h> <bs>

	function Remove_pair() abort
	  let pair = getline('.')[ col('.')-2 : col('.')-1 ]
	  return stridx('""''''()[]<>{}', pair) % 2 == 0 ? "\<del>\<c-h>" : "\<bs>"
	endfunction
]]

-- quickhand refinment
Keyboard.command('W', 'w', {})
Keyboard.command('Wq', 'wq', {})
Keyboard.command('WQ', 'wq', {})
Keyboard.command('Edit', 'edit', {})

-- quit from current window
Keyboard.map("n", "ó", ":q<CR>")

-- remove highlights
Keyboard.map("n", "ö", ":noh<CR>")

-- Better window navigation
Keyboard.map("n", "<Leader>h", "<C-w>h")
Keyboard.map("n", "<Leader>j", "<C-w>j")
Keyboard.map("n", "<Leader>k", "<C-w>k")
Keyboard.map("n", "<Leader>l", "<C-w>l")
Keyboard.map("n", "<Leader>é", "<C-w>l")

-- Spell checking 
vim.opt.spelllang={'en'}
vim.opt.spell = false

Keyboard.command('SpellIn',  ":lua vim.opt.spell = true")
Keyboard.command('SpellOut', ":lua vim.opt.spell = false")

