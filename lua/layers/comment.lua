Terminal = require("utils.terminal")
Package = require("utils.package")

Comment = {}

Comment.excludeOs = {
	Terminal.TERMUX
}



Comment.packages = {
	'numToStr/Comment.nvim'
}

Comment.comment = nil

Comment.init = function()
	Comment.comment = Package.want("Comment")

	if not Comment.comment then return false end

	Comment.comment.setup()
end

return Comment
