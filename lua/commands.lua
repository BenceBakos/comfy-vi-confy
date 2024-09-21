Commands      = {}

Commands.init = function(Keyboard)
	-- Package managger functionality
	Keyboard.command('PackagesUpdate', ':lua Package.update()', {})
	Keyboard.command('PackagesClean', ':lua Package.clean()', {})


	-- spell check
	Keyboard.command('SpellIn', ":lua vim.opt.spell = true")
	Keyboard.command('SpellOut', ":lua vim.opt.spell = false")
end


return Commands
