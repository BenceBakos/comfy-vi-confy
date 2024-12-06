Terminal = require("utils.terminal")

Touch = {}

Touch.excludeOs = {
	-- Terminal.TERMUX
}

Touch.envCommands = {
	-- debian =  {'',''}
}

Touch.packages = {
	-- ''
}

Touch.init = function()
	-- print('hello')
end

Touch.options = {
	g = {

	},
	opt = {
		-- signcolumn = 'number'
	}
}

Touch.commands = {
	-- Cpath = ":let @+=expand('%')"
}

Touch.autocmds = {
	-- {events = { 'BufReadPost' }, settings ={ pattern = { '*' }, callback = function() end}}
}

Touch.maps = {
	-- {mode='n', map='th',to= ':tabfirst<CR>',options = false},
	-- {mode='', map='', to=function() end,options=false}
}

return Touch
