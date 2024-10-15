Terminal = require("utils.terminal")
Lsp = require("layers.lsp")

Php = {}

Php.excludeOs = {
	Terminal.TERMUX
}

Php.dependencyBinaries = {
	debian = { 'php', 'composer' },
	arch = { 'php', 'composer' }
}

Php.init = function()

	-- LspConfig.intelephense.setup({
	-- 	capabilities = capabilities,
	-- 	init_options = {
	-- 		licenceKey = File.get_intelephense_license()
	-- 	},
	-- })
	Lsp.lspconfig.phpactor.setup({
		init_options = {
			["language_server_phpstan.enabled"] = true,
			["language_server_psalm.enabled"] = true,
			["language_server_php_cs_fixer.enabled"] = true,
			["php_code_sniffer.enabled"] = true,
		},
		capabilities = Lsp.capabilities
	})
end

return Php
