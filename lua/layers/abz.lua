Terminal = require("utils.terminal")
Keyboard = require("utils.keyborad")
Table = require("utils.table")
Tui = require("utils.tui")

Abz = {}

Abz.init = function()

end

Abz.maps = {
}

Abz.autocmds = {

}

Abz.commands = {
	HomeScreen = ':lua Abz.homeScreen()'
}

Abz.homeScreen = function()
	local FILES_KEY = 'Files'
	Tui.table({
		FILES_KEY = FILES_KEY
	}, function()
		Log.log('lol')
	end)
end

return Abz
