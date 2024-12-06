Terminal = require("utils.terminal")
Package = require("utils.package")
Keyboard = require("utils.keyborad")


Git = {}

Git.excludeOs = {
	Terminal.TERMUX
}



 -- TODO optional depdendency for lazygit

Git.packages = {
	'f-person/git-blame.nvim'
}


Git.options = {
	g = {
		gitblame_enabled = 0
	}
}

Git.maps= {
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
				Keyboard.feed(":vsplit<CR><C-w>l:terminal lazygit<CR>", "n")
				return
			end

			Keyboard.feed(":vsplit<CR><C-w>l :terminal<CR>", "n")
		end
	}
}

return Git
