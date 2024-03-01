Commands      = {}

Commands.init = function(Keyboard)
	-- Package managger functionality
	Keyboard.command('PackagesUpdate', ':lua Package.update()', {})
	Keyboard.command('PackagesClean', ':lua Package.clean()', {})


	-- copy path to clipboard
	Keyboard.command('Cgpath', ":let @+=expand('%:p')")
	Keyboard.command('Cpath', ":let @+=expand('%')")

	-- quickhand refinment
	Keyboard.command('W', 'w', {})
	Keyboard.command('Wq', 'wq', {})
	Keyboard.command('WQ', 'wq', {})
	Keyboard.command('Edit', 'edit', {})


	-- spell check
	Keyboard.command('SpellIn', ":lua vim.opt.spell = true")
	Keyboard.command('SpellOut', ":lua vim.opt.spell = false")
end


return Commands
