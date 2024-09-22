Terminal = require("utils.terminal")

Ide = {}

Ide.excludeOs = {
	Terminal.TERMUX
}

Ide.dependencyBinaries = {
	-- debian =  {'git', 'fz'}
}

Ide.envCommands = {
	-- debian =  {'',''}
}

Ide.plugins = {
	-- ''
}

Ide.init = function()
	-- print('hello')
end

Ide.options = {
	g = {

	},
	opt = {
		-- signcolumn = 'number'
	}
}

Ide.commands = {
	-- Cpath = ":let @+=expand('%')"
}

Ide.autocmds = {
	-- twig shall be regarded as html
	{
		events = { 'BufReadPost' },
		settings = {
			pattern = { '*.html.twig' },
			callback = function()
				vim.bo.filetype = "html"
			end
		}
	},
	{
		events = { 'BufEnter' },
		settings = {
			pattern = { '*.blade.php' },
			callback = function()
				vim.opt.autoindent = true
			end
		}
	}
}

Ide.maps = {
	-- {mode='n', map='th',to= ':tabfirst<CR>',options = false},
}

Ide.mapFunctions = {
	-- {mode='', map='', to=function() end,options=false}
}

return Ide
