Terminal = require("utils.terminal")

Web = {}

Web.excludeOs = {
	Terminal.TERMUX
}

Web.dependencyBinaries = {
	debian = { 'node', 'npm' },
	arch = { 'node', 'npm' }
}

Web.init = function()
	local LspConfig = Package.want("lspconfig")
	if not LspConfig then return false end

	LspConfig.tailwindcss.setup({})
	LspConfig.quick_lint_js.setup({})
	LspConfig.cssls.setup({})
	LspConfig.ts_ls.setup {}

end

return Web
