Terminal = require("utils.terminal")
Package = require("utils.package")
Keyboard = require("utils.keyborad")

Oil = {}

Hop.excludeOs = {
	Terminal.TERMUX
}

Oil.packages = {
	'stevearc/oil.nvim'
}

Oil.init = function()
	require("oil").setup()

	local oil = Package.want("oil")

	if not oil then return false end

	oil.setup({
		view_options = {
			show_hidden = true,
		},
		sort = {
			{ "mtime", "desc" },
		},
	})
end

Oil.maps = {
	{ mode = "n", map = "-",  to = ":Oil<CR>" },
	{ mode = "n", map = "t-", to = ":vsplit<CR>:Oil<CR>" }
}

return Oil
