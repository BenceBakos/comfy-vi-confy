Terminal = require("utils.terminal")

Sample = {}

Sample.excludeOs = {
	-- Terminal.TERMUX
}

Sample.dependencyBinaries = {
	-- debian =  {'git', 'fz'}
}

Sample.envCommands = {
	-- debian =  {'',''}
}

Sample.packages = {
	-- ''
}

Sample.init = function()
	-- print('hello')
end

Sample.options = {
	g = {

	},
	opt = {
		-- signcolumn = 'number'
	}
}

Sample.commands = {
	-- Cpath = ":let @+=expand('%')"
}

Sample.autocmds = {
	-- {events = { 'BufReadPost' }, settings ={ pattern = { '*' }, callback = function() end}}
}

Sample.maps = {
	-- {mode='n', map='th',to= ':tabfirst<CR>',options = false},
	-- {mode='', map='', to=function() end,options=false}
}

return Sample
