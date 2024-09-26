Terminal = require("utils.terminal")
Package = require("utils.package")

Spell = {}

Spell.packages = {
	'f-person/git-blame.nvim'
}

Spell.options = {
	opt = {
		spelllang = { 'en' },
		spell = false
	}
}

Spell.commands = {
	SpellIn = ":lua vim.opt.spell = true",
	SpellOut = ":lua vim.opt.spell = false"
}

return Spell
