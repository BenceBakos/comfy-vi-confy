Terminal = require("utils.terminal")

Erik = {}

Erik.excludeOs = {
	Terminal.TERMUX
}

Erik.packages = {
	"nvim-lua/plenary.nvim",
	"ravitemer/mcphub.nvim"
}

Erik.mcphub = nil

Erik.init = function()
	Erik.mcphub = Package.want("mcphub")

	if not Erik.mcphub then return false end

	Erik.mcphub.setup()
end

return Erik
