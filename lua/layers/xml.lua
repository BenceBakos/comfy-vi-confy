Terminal = require("utils.terminal")

Xml = {}

Xml.excludeOs = {
	Terminal.TERMUX
}

Xml.init = function()
	local LspConfig = Package.want("lspconfig")
	if not LspConfig then return false end

	LspConfig.lemminx.setup({})
end

return Xml
