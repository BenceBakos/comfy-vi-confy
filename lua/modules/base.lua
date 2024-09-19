
Terminal = require("utils.terminal")

Base = {}

Base.excludeOs = {
	-- Terminal.TERMUX
}

Base.dependencyBinaries = {
	-- debian =  'git fz'
}

Base.envCommands = {
	-- debian =  {'',''}
}

Base.plugins = {
	-- ''
}

Base.init = function()
	-- print('hello')
end

Base.options = {
	g = {

	},
	opt = {
		-- signcolumn = 'number'
	}
}

Base.commands = {
	-- Cpath = ":let @+=expand('%')"
}

Base.autocmds = {
	-- {events = { 'BufReadPost' }, pattern = { '*' } callback = function() end}
}

Base.maps = {
	-- {mode='', map='', to=''}
}

Base.mapFunctions = {
	-- {mode='', map='', to=function() end}
}

return Base
