Terminal = require("utils.terminal")
Keyboard = require("utils.keyborad")
Table = require("utils.table")
Tui = require("utils.tui")
File = require("utils.file")

Abz = {}

Abz.excludeOs = {
	Terminal.ARCH,
	Terminal.DEBIAN,
}


Abz.init = function()
end

Abz.maps = {
}

Abz.autocmds = {
	{
		events = { "VimEnter" },
		settings = {
			pattern = "*",
			callback = function()
				if #vim.fn.argv() == 0 then
					vim.api.nvim_command('HomeScreenInCurrent')
				end
			end
		}

	}

}

Abz.commands = {
	HomeScreenInCurrent = ':lua Abz.homeScreen(true)',
	HomeScreen = ':lua Abz.homeScreen()'
}

Abz.homeScreen = function(openInCurrent)
	local FILES = 'FILES'
	local SHARED = 'SHARED'
	local PROJECT = 'PROJECT'

	Tui.table({
		FILES = FILES,
		SHARED = SHARED,
		PROJECT = PROJECT
	}, function(value)
		if value == FILES then
			vim.api.nvim_command('Oil')
		end

		if value == SHARED then
			vim.api.nvim_command('Oil ' .. File.getPersistnecyPath())
		end

		if value == PROJECT then
			vim.api.nvim_command('Oil .')
		end
	end, openInCurrent)
end

return Abz
