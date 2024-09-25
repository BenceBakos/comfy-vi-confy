Terminal = require("utils.terminal")

Lsp = {}

Lsp.excludeOs = {
	Terminal.TERMUX
}

Lsp.dependencyBinaries = {
	debian =  {'git', 'curl', 'unzip'} -- TODO gzip as an optional
}

Lsp.envCommands = {
	-- debian =  {'',''}
}

Lsp.plugins = {
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
	'saadparwaiz1/cmp_luasnip',
}

Lsp.init = function()

	-- LSP, DAP related sys dependency installer(requires some package managgers like npm, depending on the server)
	local Mason = Package.want("mason")

	if not Mason then return false end

	Mason.setup()

	-- Autoinstall LSP, DAP servers
	local MasonLsp = Package.want("mason-lspconfig")

	if not MasonLsp then return false end

	MasonLsp.setup {
		automatic_installation = true
	}

	-- LuaSnip
	local LuaSnipLoader = Package.want("luasnip.loaders.from_vscode")
	local LuaSnip = Package.want("luasnip")

	if not LuaSnipLoader or not LuaSnip then return false end

	LuaSnipLoader.lazy_load()

	-- CMP
	local Cmp = Package.want("cmp")

	if not Cmp then return false end

	Cmp.setup({
		snippet = {
			expand = function(args)
				LuaSnip.lsp_expand(args.body)
			end
		},
		sources = {
			{ name = 'nvim_lsp', keyword_length = 2 },
			{ name = 'path',     keyword_length = 2 },
			{ name = 'buffer',   keyword_length = 2 },
			{ name = 'luasnip',  keyword_length = 2 },
		},
		mapping = {
			['<CR>'] = Cmp.mapping.confirm({
				behavior = Cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			["<Tab>"] = Cmp.mapping(function(fallback)
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				local hasWordsBefore = col ~= 0 and
					vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil

				if Cmp.visible() then
					Cmp.select_next_item()
				elseif hasWordsBefore then
					Cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = Cmp.mapping(function(fallback)
				if Cmp.visible() then
					Cmp.select_prev_item()
				elseif LuaSnip.jumpable(-1) then
					LuaSnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}
	})



end

Lsp.options = {
	g = {

	},
	opt = {
		-- signcolumn = 'number'
	}
}

Lsp.commands = {
	-- Cpath = ":let @+=expand('%')"
}

Lsp.autocmds = {
	-- twig shall be regarded as html
	{
		events = { 'BufReadPost' },
		settings = {
			pattern = { '*.html.twig' },
			callback = function()
				vim.bo.filetype = "html"
			end
		}
	},
	{
		events = { 'BufEnter' },
		settings = {
			pattern = { '*.blade.php' },
			callback = function()
				vim.opt.autoindent = true
			end
		}
	}
}

Lsp.maps = {
	-- {mode='n', map='th',to= ':tabfirst<CR>',options = false},
}

Lsp.mapFunctions = {
	-- {mode='', map='', to=function() end,options=false}
}

return Lsp
