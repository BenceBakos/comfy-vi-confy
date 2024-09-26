Terminal = require("utils.terminal")
Package = require("utils.package")

GitBlame = {}

GitBlame.packages = {
	'f-person/git-blame.nvim'
}


GitBlame.options = {
	g = {
		gitblame_enabled = 0
	}
}


return GitBlame
