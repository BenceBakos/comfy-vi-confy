Terminal = require("utils.terminal")
Package = require("utils.package")

Treesitter = {}

Treesitter.excludeOs = {
	-- Terminal.TERMUX
}

Treesitter.packages = {
	'nvim-treesitter/nvim-treesitter',
	'drybalka/tree-climber.nvim',
}

Treesitter.treeclimber = nil

Treesitter.init = function()
	local treesitter = Package.want('nvim-treesitter.configs')

	if not treesitter then return false end

	treesitter.setup {
		-- A list of parser names, or "all" (the five listed parsers should always be installed)
		ensure_installed = { "c", "lua", "vim", "vimdoc", "query", 'php', 'json', 'javascript', 'ssh_config', 'sql', 'tmux', 'toml', 'tsv', 'twig', 'typescript', 'vue', 'xml', 'yaml' },

		ignore_install = {},
		modules = {},

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		indent = {
			enable = true
		}
	}


	Treesitter.treeclimber = Package.want('tree-climber')
end

Treesitter.maps = {
	{
		mode = { 'n', 'v', 'o' },
		map = 'H',
		to = function()
			if not Treesitter.treeclimber then return false end
			Treesitter.treeclimber.goto_parent()
		end
	},
	{
		mode = { 'n', 'v', 'o' },
		map = 'L',
		to = function()
			if not Treesitter.treeclimber then return false end
			Treesitter.treeclimber.goto_child()
		end
	},
	{
		mode = { 'n', 'v', 'o' },
		map = 'J',
		to = function()
			if not Treesitter.treeclimber then return false end
			Treesitter.treeclimber.goto_next()
		end
	},
	{
		mode = { 'n', 'v', 'o' },
		map = 'K',
		to = function()
			if not Treesitter.treeclimber then return false end
			Treesitter.treeclimber.goto_prev()
		end
	},
	{
		mode = { 'v', 'o' },
		map = 'in',
		to = function()
			if not Treesitter.treeclimber then return false end
			Treesitter.treeclimber.select_node()
		end
	},
	{
		mode = 'n',
		map = '<c-k>',
		to = function()
			if not Treesitter.treeclimber then return false end
			Treesitter.treeclimber.swap_prev()
		end
	},
	{
		mode = 'n',
		map = '<c-j>',
		to = function()
			if not Treesitter.treeclimber then return false end
			Treesitter.treeclimber.swap_next()
		end
	},
	{
		mode = 'n',
		map = '<c-h>',
		to = function()
			if not Treesitter.treeclimber then return false end
			Treesitter.treeclimber.highlight_node()
		end
	},

}


return Treesitter
