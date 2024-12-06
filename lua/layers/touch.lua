Terminal = require("utils.terminal")
File = require("utils.file")

Touch = {}

Touch.excludeOs = {
	-- Terminal.DEBIAN,
	-- Terminal.ARCH,
}

Touch.envCommands = {
	-- debian =  {'',''}
}

Touch.packages = {
}

Touch.init = function()
end

Touch.options = {
	g = {

	},
	opt = {
		mouse = 'a'
	}
}

Touch.commands = {
	-- Cpath = ":let @+=expand('%')"
}

Touch.autocmds = {
	-- {events = { 'BufReadPost' }, settings ={ pattern = { '*' }, callback = function() end}}
}

Touch.maps = {
	-- {mode='', map='', to=function() end,options=false}
	{
		mode = 'n',
		map = '<ScrollWheelUp>',
		to = function()
			vim.api.nvim_buf_set_lines(0, 0, -1, false, { "scroll up" })
		end,
		options = false
	},
	{
		mode = 'n',
		map = '<ScrollWheelDown>',
		to = function()
			vim.api.nvim_buf_set_lines(0, 0, -1, false, { "scroll down" })
		end,
		options = false
	},
	{
		mode = 'n',
		map = '<ScrollWheelLeft>',
		to = function()
			vim.api.nvim_buf_set_lines(0, 0, -1, false, { "scroll left" })
		end,
		options = false
	},
	{
		mode = 'n',
		map = '<ScrollWheelRight>',
		to = function()
			vim.api.nvim_buf_set_lines(0, 0, -1, false, { "scroll right" })
		end,
		options = false
	},
	{
		mode = 'n',
		map = '<LeftMouse>',
		to = function()
			-- Get the mouse position
			local mouse_pos = vim.fn.getmousepos()
			local x = mouse_pos.wincol
			local y = mouse_pos.winrow

			vim.api.nvim_buf_set_lines(0, 0, -1, false, { "click at"..x.."  "..y })
		end,
		options = { noremap = true, silent = true }
	}
}

return Touch
