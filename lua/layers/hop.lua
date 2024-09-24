Terminal = require("utils.terminal")
Package = require("utils.package")

Hop = {}

Hop.excludeOs = {
	Terminal.TERMUX
}

Hop.packages = {
	'smoka7/hop.nvim'
}

Hop.hop = nil

Hop.init = function()
	Hop.hop = Package.want("hop")

	if not Hop.hop then return false end

	Hop.hop.setup()
end

Hop.mapFunctions = {
	{
		mode = { "n", "v" },
		map = '<Leader><Leader>',
		to = function()
			if not Hop.hop then return nil end
			Hop.hop.hint_words({
				multi_windows = true
			})
		end
	}
}


return Hop
