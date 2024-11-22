Terminal = require("utils.terminal")
Package = require("utils.package")

Treesitter = {}

Treesitter.excludeOs = {
	-- Terminal.TERMUX
}

Treesitter.packages = {
	'nvim-treesitter/nvim-treesitter',
	'nvim-treesitter/nvim-treesitter-refactor',
	'Wansmer/treesj'
}

Treesitter.treesj = nil

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
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gm", -- set to `false` to disable one of the mappings
				node_incremental = "gm",
				scope_incremental = false,
				node_decremental = "gM",
			},
		},
		-- refactor = {
		-- 	highlight_definitions = {
		-- 		enable = true,
		-- 		clear_on_cursor_move = true,
		-- 	},
		-- 	highlight_current_scope = { enable = true },
		-- 	navigation = {
		-- 		enable = true,
		-- 		-- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
		-- 		keymaps = {
		-- 			goto_definition_lsp_fallback = "gd",
		-- 			goto_next_usage = "gn",
		-- 			goto_previous_usage = "gN",
		-- 		},
		-- 	},
		-- },
	}

	Treesitter.treesj = Package.want('treesj')

	if not Treesitter.treesj then return false end

	Treesitter.treesj.setup({
		use_default_keymaps = false,
		max_join_length = 1000
	})
end

Treesitter.maps = {
	{
		mode = "n",
		map = "gs",
		to = function()
			Treesitter.treesj.toggle()
		end
	},
}


return Treesitter
