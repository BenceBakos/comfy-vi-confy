Terminal = require("utils.terminal")

Python = {}

Python.excludeOs = {
	Terminal.TERMUX
}


Python.init = function()
	local LspConfig = Package.want("lspconfig")
	local CmpNvimLsp = Package.want("cmp_nvim_lsp")
	if not LspConfig or not CmpNvimLsp then return false end

	LspConfig.pyright.setup({
		capabilities = CmpNvimLsp.default_capabilities(),
	})
end

return Python
