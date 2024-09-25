Terminal = require("utils.terminal")

Nix = {}

Nix.excludeOs = {
	Terminal.TERMUX
}

Nix.dependencyBinaries = {
	debian = { 'nix' },
	arch = { 'nix' }
}


Nix.init = function()
	local LspConfig = Package.want("lspconfig")
	if not LspConfig then return false end

	LspConfig.rnix.setup {}
end

return Nix
