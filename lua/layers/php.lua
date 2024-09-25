Terminal = require("utils.terminal")

Php = {}

Php.excludeOs = {
	Terminal.TERMUX
}

Php.dependencyBinaries = {
	debian = { 'php', 'composer' },
	arch = { 'php', 'composer' }
}

Php.init = function()
	local LspConfig = Package.want("lspconfig")
	if not LspConfig then return false end

	-- https://github.com/williamboman/mason-lspconfig.nvim
	-- lspconfig.pylsp.setup({})
	-- lspconfig.intelephense.setup({
	--    init_options = {
	--        licenceKey = File.get_intelephense_license()
	--    }
	--})
	LspConfig.phpactor.setup({
		init_options = {
			["language_server_phpstan.enabled"] = false,
			["language_server_psalm.enabled"] = false,
		},
	})

end

return Php
