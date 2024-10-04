Terminal = require("utils.terminal")
Package = require("utils.package")
Keyboard = require("utils.keyborad")

Theme = {}

Theme.excludeOs = {
	Terminal.TERMUX
}

Theme.packages = {
	'xiyaowong/transparent.nvim'
}

Theme.init = function()
	Keyboard.feed(':TransparentEnable<CR>:<CR>','n')
end

return Theme
