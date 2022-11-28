require("os")
require("io")
----------
-- GLOBALS
----------
DEBUGGERBASE = "/home/b/debugger/"
PHPDAPSERVERROOT = "/var/www/html/"

----------
-- GLOBALS END
----------

----------
-- HELPERS
----------
function log(msg)
	local f = io.open(os.getenv("HOME") .. "/nvim.error", "a")
	if msg and f then
		io.output(f)
		f.write(f, msg .. "\n")
		io.close(f)
	end
end

function keymap(mode, keys, cmd, opts)
	if not opts then
		opts = { noremap = true, silent = true }
	end

	vim.api.nvim_set_keymap(mode, keys, cmd, opts)
end

function file_exists(file)
	-- some error codes:
	-- 13 : EACCES - Permission denied
	-- 17 : EEXIST - File exists
	-- 20	: ENOTDIR - Not a directory
	-- 21	: EISDIR - Is a directory
	--
	local isok, errstr, errcode = os.rename(file, file)
	if isok == nil then
		if errcode == 13 then
			-- Permission denied, but it exists
			return true
		end
		return false
	end
	return true
end

local function has_words_before()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function feed(keys, mode)
	local keysReplaced = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(keysReplaced, mode, true)
end

function wait(seconds)
	local start = os.time()
	repeat
	until os.time() > start + seconds
end

----------
-- HELPERS END
----------

local function scripts()
	local scriptTable = {}

	scriptTable['installphpdebugger'] = function()
		feed(":tab ter<CR>i", "n")
		feed("sudo pacman -Sy --noconfirm xdebug<Esc>", "t")

		feed(":tabedit<Space><CR>:tab ter<CR>i", "n")
		feed(
			"ls " .. DEBUGGERBASE .. " 2>/dev/null||mkdir " .. DEBUGGERBASE .. " && " ..
			"cd " .. DEBUGGERBASE .. " &&" ..
			"git clone https://github.com/xdebug/vscode-php-debug.git && " ..
			"cd vscode-php-debug &&" ..
			"npm install && npm run build<CR>"
			, "t")
	end

	for name, script in pairs(scriptTable) do
		vim.api.nvim_create_user_command('Run' .. name, script, {})
	end
end

local function magic()

	-- auto install packer
	local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		PACKER_BOOTSTRAP = vim.fn.system {
			"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path,
		}
		print "Installing packer, close and reopen Neovim..."
		vim.cmd [[packadd packer.nvim]]
	end

	-- install packages
	require "packer".startup(function(use)
		-- use packer in packer lol?
		use "wbthomason/packer.nvim"

		-- Useful lua functions used ny lots of plugins
		use "nvim-lua/plenary.nvim"

		--LSP
		use {
			'junnplus/lsp-setup.nvim',
			requires = {
				'neovim/nvim-lspconfig',
				'williamboman/mason.nvim',
				'williamboman/mason-lspconfig.nvim',
			}
		}

		--snippets for autocomplete,cmdline
		use "L3MON4D3/LuaSnip"
		use "hrsh7th/nvim-cmp"
		use "hrsh7th/cmp-buffer"
		use "hrsh7th/cmp-path"
		use "hrsh7th/cmp-cmdline"
		use "saadparwaiz1/cmp_luasnip"
		use "hrsh7th/cmp-nvim-lsp"

		-- flutter
		use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }
		use 'natebosch/dartlang-snippets'
		use { 'thosakwe/vim-flutter' }

		-- fuzzy find
		use {
			'nvim-telescope/telescope.nvim', tag = '0.1.0',
			requires = { { 'nvim-lua/plenary.nvim' } }
		}

		-- git integration
		use 'dinhhuy258/git.nvim'


		-- debugger
		use 'mfussenegger/nvim-dap'
	end)

	-- autocomplete
	local cmp = require 'cmp'
	local luasnip = require "luasnip"
	cmp.setup {
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		sources = {
			{ name = 'nvim_lsp' }
		},
		mapping = cmp.mapping.preset.insert({
			['<CR>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_prev_item()
				end
			end, { "i", "s" }),
		}),
	}

	-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

	-- flutter
	require("flutter-tools").setup {
		lsp = { settings = { enableSnippets = true, } }
	}

	--easy lsp setup
	-- https://github.com/junnplus/lsp-setup.nvim
	require('lsp-setup').setup({
		servers = {
			pylsp = {},
			sumneko_lua = {
				settings = {
					Lua = {
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { 'vim' },
						},
					},
				},
			},
			intelephense = {},
			eslint = {},
			bashls = {},
		},
		on_attach = function(client, bufnr)
		end,
	})

	-- telescope: fuzzy finder
	require('telescope').setup()

	-- GIT integration
	require('git').setup()

	-- debugger client
	local dap = require('dap')

	--DAP PHP
	if file_exists(DEBUGGERBASE .. "vscode-php-debug/") then
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
				serverSourceRoot = PHPDAPSERVERROOT,
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

end

local function custom_magic()
	

	
	

	

end

local function keymaps()
	

	

	-- telescope
	vim.keymap.set('n', '<Leader>c', require('telescope.builtin').find_files)

	-- lsp
	keymap('n', '<Leader>f', ':lua vim.lsp.buf.formatting()<CR>')

	-- dap
	keymap('n', '<Leader>b', ':lua require"dap".toggle_breakpoint()<CR>')
	keymap('n', '<Leader>n', ':lua require"dap".continue()<CR>')
	keymap('n', '<Leader>i', ':lua require"dap".step_into()<CR>')
	keymap('n', '<Leader>o', ':lua require"dap".step_over)<CR>')
	keymap('n', '<Leader>s', ':lua require("dap").repl.open({}, "vsplit")<CR>')

end

function project_specific()
	if file_exists(".nvim.lua") then
		dofile(".nvim.lua")
	end
end

-- init
project_specific()
scripts()
magic()
custom_magic()
settings()
keymaps()
