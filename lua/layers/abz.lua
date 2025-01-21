Terminal = require("utils.terminal")
Keyboard = require("utils.keyborad")
Table = require("utils.table")
Tui = require("utils.tui")
File = require("utils.file")

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
	local SHARED = 'SHARED'
	Tui.table({
		FILES = FILES,
		SHARED = SHARED
	}, function(value)
		if value == FILES then
			vim.api.nvim_command('Oil')
		end

		if value == SHARED then
			vim.api.nvim_command('Oil '..File.getPersistnecyPath())
		end
	end)
end

return Abz
