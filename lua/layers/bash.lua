Terminal = require("utils.terminal")

Bash = {}

Bash.excludeOs = {
	Terminal.TERMUX
}


Bash.dependencyBinaries = {
	debian = { 'node','npm' },
	arch = { 'node','npm' }
}

Bash.init = function()
	local LspConfig = Package.want("lspconfig")
	if not LspConfig then return false end

	LspConfig.bashls.setup({})
end

return Bash
