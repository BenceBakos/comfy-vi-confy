Terminal = require("utils.terminal")
Package = require("utils.package")
Keyboard = require("utils.keyborad")

Notes = {}

Notes.excludeOs = {
	Terminal.TERMUX
}

Notes.maps = {
	{
		mode = 'n',
		map = 'tn',
		to = function()

		end
	},
	{
		mode = 'n',
		map = 'né',
		to = function()

		end
	}
}



return Notes
