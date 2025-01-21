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
	local FILES = 'FILES'
	Tui.table({
		FILES = FILES
	}, function()
		vim.api.nvim_command('Oil')
	end)
end

return Abz
