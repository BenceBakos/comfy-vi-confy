Terminal = require("utils.terminal")
File = require("utils.file")

Touch = {}

Touch.excludeOs = {
	Terminal.DEBIAN,
	Terminal.ARCH,
}

Touch.envCommands = {
	-- debian =  {'',''}
}

Touch.packages = {
}

Touch.init = function()
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
