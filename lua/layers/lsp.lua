Terminal = require("utils.terminal")

Lsp = {}

Lsp.excludeOs = {
	Terminal.TERMUX
}

Lsp.dependencyBinaries = {
	debian = { 'git', 'curl', 'unzip' }, -- TODO gzip as an optional
	arch = { 'git', 'curl', 'unzip' } -- TODO gzip as an optional
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
			{ name = 'buffer',   keyword_length = 1 },
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


	local CmpLsp = Package.want('cmp_nvim_lsp')
	local LspConfig = Package.want('lspconfig')

	if not CmpLsp or not LspConfig then return false end

	-- Extend cmp capabilities
	local lspDefaults = LspConfig.util.default_config

	lspDefaults.capabilities = vim.tbl_deep_extend(
		'force',
		lspDefaults.capabilities,
		CmpLsp.default_capabilities()
	)
end

Lsp.options = {
	opt = {
		completeopt = { 'menu', 'menuone', 'noselect' }
	}
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
	{ mode = 'n', map = 'K',   to = '<cmd>lua vim.lsp.buf.hover()<cr>',                   options = false },
	{ mode = 'n', map = 'gd',  to = '<cmd>lua vim.lsp.buf.definition()<cr>',              options = false },
	{ mode = 'n', map = 'gD',  to = '<cmd>lua vim.lsp.buf.declaration()<cr>',             options = false },
	{ mode = 'n', map = 'gi',  to = '<cmd>lua vim.lsp.buf.implementation()<cr>',          options = false },
	{ mode = 'n', map = 'gt',  to = '<cmd>lua vim.lsp.buf.type_definition()<cr>',         options = false },
	{ mode = 'n', map = 'gr',  to = '<cmd>lua vim.lsp.buf.references()<cr>',              options = false },
	{ mode = 'n', map = 'gk',  to = '<cmd>lua vim.lsp.buf.signature_help()<cr>',          options = false },
	{ mode = 'n', map = 'grn', to = '<cmd>lua vim.lsp.buf.rename()<cr>',                  options = false },
	{ mode = 'n', map = 'ga',  to = '<cmd>lua vim.lsp.buf.code_action()<cr>',             options = false },
	{ mode = 'n', map = 'gof', to = '<cmd>lua vim.diagnostic.open_float()<cr>',           options = false },
	{ mode = 'n', map = 'gm',  to = '<cmd>lua vim.diagnostic.goto_prev()<cr>',            options = false },
	{ mode = 'n', map = 'gM',  to = '<cmd>lua vim.diagnostic.goto_next()<cr>',            options = false },
	{ mode = 'n', map = 'gwa', to = '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>',    options = false },
	{ mode = 'n', map = 'gwr', to = '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', options = false },
	{
		mode = 'n',
		map = 'gF',
		to = function()
			vim.lsp.buf.format { async = true }
		end,
		options = false
	}
}

return Lsp
