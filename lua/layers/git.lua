Terminal = require("utils.terminal")
Package = require("utils.package")
Keyboard = require("utils.keyborad")

Git = {}

 -- TODO optional depdendency for lazygit

Git.packages = {
	'f-person/git-blame.nvim'
}


Git.options = {
	g = {
		gitblame_enabled = 0
	}
}

Fuzzy.mapFunctions = {
	{
		mode = 'n',
		map = 'tg',
		to = function()
			if Terminal.binaryExists('lazygit') then
				Keyboard.feed(":tab terminal lazygit<CR>", "n")
				return
			end

			Keyboard.feed(":tab terminal<CR>", "n")
		end
	},
	{
		mode = 'n',
		map = 'gé',
		to = function()
			if Terminal.binaryExists('lazygit') then
				Keyboard.feed(":botright vnew<Space><CR>:tab terminal lazygit<CR>", "n")
				return
			end

			Keyboard.feed(":botright vnew<Space><CR>:tab terminal<CR>", "n")
		end
	}
}


return Git
