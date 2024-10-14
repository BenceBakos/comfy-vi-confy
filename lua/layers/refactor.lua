Terminal = require("utils.terminal")
Package = require("utils.package")
Keyboard = require("utils.keyborad")

Refactor = {}

Refactor.excludeOs = {
	Terminal.TERMUX
}

Refactor.packages = {
	'nvim-lua/plenary.nvim',
	'nvim-treesitter/nvim-treesitter',
	'ThePrimeagen/refactoring.nvim'
}

Refactor.init = function()
	local Refactor = Package.want("refactoring")

	if not Refactor then return false end

	Refactor.setup()
end

return Refactor
