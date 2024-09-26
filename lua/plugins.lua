Plugins = {}

Plugins.init = function(Package)
	-- Packages
	Package.install({
		'aklt/plantuml-syntax',
		'weirongxu/plantuml-previewer.vim',
		'f-person/git-blame.nvim',
		'nvim-lua/plenary.nvim',
		'stevearc/dressing.nvim',
	})

end

return Plugins
