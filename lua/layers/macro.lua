Terminal = require("utils.terminal")
Package = require("utils.package")
Keyboard = require("utils.keyborad")

Macro = {}

Macro.excludeOs = {
	Terminal.TERMUX
}

Macro.packages = {
	'tani/dmacro.vim'
}


Macro.maps = {
	{ mode = "n", map = "m",  to = "<Plug>(dmacro-play-macro)" },
}

return Macro
