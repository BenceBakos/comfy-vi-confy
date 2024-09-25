Terminal = require("utils.terminal")

Yaml = {}

Yaml.excludeOs = {
	Terminal.TERMUX
}

Yaml.dependencyBinaries = {
	debian = { 'node', 'npm' },
	arch = { 'node', 'npm' }
}

Yaml.init = function()
	local LspConfig = Package.want("lspconfig")
	if not LspConfig then return false end

	LspConfig.yamlls.setup({})
end

return Yaml
