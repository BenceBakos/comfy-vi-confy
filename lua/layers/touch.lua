Terminal = require("utils.terminal")
File = require("utils.file")

Touch = {}

Touch.leftReleaseHandler = {}

Touch.init = function()
	vim.cmd('tabedit a')
	vim.cmd('tabedit b')
	vim.cmd('tabedit c')
	for eventName, handlers in pairs(Touch.handlers) do
		table.insert(Touch.maps, {
			mode = 'n',
			map = eventName,
			to = function()
				local dimensions = Touch.getDimensions()

				Touch.logEvent(
					eventName,
					dimensions.wincol,
					dimensions.winrow,
					dimensions.winid
				)

				for _, handler in pairs(handlers) do
					handler(dimensions)
				end
			end,
			options = { noremap = false, silent = true },
		})
	end
end

-- '<ScrollWheelUp>',
-- '<ScrollWheelDown>',
Touch.handlers = {}

Touch.handlers['<LeftRelease>'] = {
	function(dimensions)
		if dimensions.wincol > (dimensions.winCols * 0.9) and dimensions.winrow < (dimensions.winRows * 0.1) then
			vim.cmd('q!')
		end
	end
}

Touch.handlers['<ScrollWheelUp>'] = {
	function(dimensions)
		if dimensions.wincol < (dimensions.winCols * 0.9) then
			vim.cmd('tabnext')
		end
	end
}

Touch.handlers['<ScrollWheelDown>'] = {
	function(dimensions)
		if dimensions.wincol < (dimensions.winCols * 0.9) then
			vim.cmd('tabprevious')
		end
	end
}

Touch.maps = {
	{ mode = 'n', map = '<4-LeftMouse>', to = '<Nop>', options = { noremap = false, silent = true } },
	{ mode = 'n', map = '<3-LeftMouse>', to = '<Nop>', options = { noremap = false, silent = true } },
	{ mode = 'n', map = '<2-LeftMouse>', to = '<Nop>', options = { noremap = false, silent = true } },
	{ mode = 'n', map = '<LeftMouse>',   to = '<Nop>', options = { noremap = false, silent = true } }
}

Touch.getDimensions = function()
	local pointer = vim.fn.getmousepos()

	return Table.merge(pointer, {
		winRows = vim.api.nvim_win_get_height(pointer.winid),
		winCols = vim.api.nvim_win_get_width(pointer.winid),
	})
end

Touch.logEvent = function(eventName, col, row, winId)
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
		" H:" .. vim.api.nvim_win_get_height(winId),
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
