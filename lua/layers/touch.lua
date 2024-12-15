Terminal = require("utils.terminal")
File = require("utils.file")

Touch = {}

Touch.leftReleaseHandler = {}

Touch.init = function()
end

Touch.maps = {
	-- '<ScrollWheelUp>',
	-- '<ScrollWheelDown>',
	-- '<2-LeftMouse>', -- tricky, has to disable text selection in termux for it to work properly
	{
		mode = 'n',
		map = '<LeftRelease>',
		to = function()
			local eventName = '<LeftRelease>'
			local pointer = vim.fn.getmousepos()
			local bufferId = vim.api.nvim_win_get_buf(pointer.winid)

			Touch.logEvent(
				eventName,
				pointer.wincol,
				pointer.winrow,
				pointer.winid,
				bufferId
			)

		end,
		options = { noremap = false, silent = true },
	},
	{ mode = 'n', map = '<4-LeftMouse>', to = '<Nop>', options = { noremap = false, silent = true } },
	{ mode = 'n', map = '<3-LeftMouse>', to = '<Nop>', options = { noremap = false, silent = true } },
	{ mode = 'n', map = '<2-LeftMouse>', to = '<Nop>', options = { noremap = false, silent = true } },
	{ mode = 'n', map = '<LeftMouse>',   to = '<Nop>', options = { noremap = false, silent = true } }

}


Touch.logEvent = function(eventName, col, row, winId, bufferId)
	-- Log the event name and coordinates
	vim.o.statusline = table.concat({
		' %t',
		'%r',
		'%m',
		'%=',
		'%{&filetype}',
		eventName ..
		" at " ..
		col ..
		" " ..
		row ..
		" W" ..
		vim.api.nvim_win_get_width(winId) ..
		" H:" .. vim.api.nvim_win_get_height(winId) .. " Win: " .. winId .. " Buf: " .. bufferId,
	}, '')
end

Touch.options = {
	g = {

	},
	opt = {
		number = false,
		fillchars = { eob = ' ' },
		mouse = 'a',
		mousefocus = false,
	}
}

Touch.autocmds = {
	-- {events = { 'BufReadPost' }, settings ={ pattern = { '*' }, callback = function() end}}
}

Touch.envCommands = {
	-- debian =  {'',''}
}

Touch.packages = {
}

Touch.excludeOs = {
	-- Terminal.DEBIAN,
	-- Terminal.ARCH,
}

return Touch
