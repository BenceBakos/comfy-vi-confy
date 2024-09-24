Terminal = require("utils.terminal")
Package = require("utils.package")

Treesitter = {}

Treesitter.excludeOs = {
	-- Terminal.TERMUX
}

Treesitter.packages = {
	'nvim-treesitter/nvim-treesitter'
}

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
	}
end

return Treesitter