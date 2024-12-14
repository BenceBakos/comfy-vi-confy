Terminal = require("utils.terminal")
File = require("utils.file")
Buffer = require("utils.buffer")

Touch = {}

Touch.bufferId = nil

Touch.separator = "#--------"

Touch.maps = {
	-- '<ScrollWheelUp>',
	-- '<ScrollWheelDown>',
	{
		mode = 'n',
		map = '<LeftRelease>',
		to = function()
			local mouse = Touch.getMouse()

			Touch.logEvent('<LeftRelease>', mouse.x, mouse.y)

			-- start handeling events for store, then for builder


		end,
		options = { noremap = false, silent = true },
	},
	{ mode = 'n', map = '<4-LeftMouse>', to = '<Nop>', options = { noremap = false, silent = true } },
	{ mode = 'n', map = '<3-LeftMouse>', to = '<Nop>', options = { noremap = false, silent = true } },
	{ mode = 'n', map = '<2-LeftMouse>', to = '<Nop>', options = { noremap = false, silent = true } },
	{ mode = 'n', map = '<LeftMouse>', to = '<Nop>', options = { noremap = false, silent = true } }

}

Touch.isLeftSide = function (x)
	return x < (Buffer.getWidth() / 2)
end

Touch.isRightSide = function (x)
	return x >= (Buffer.getWidth() / 2)
end

Touch.getMouse = function()
	local mousePos = vim.fn.getmousepos()
	return {
		x = mousePos.wincol,
		y = mousePos.winrow
	}
end

Touch.logEvent = function(eventName, x, y)
	-- Log the event name and coordinates
	vim.o.statusline = table.concat({
		' %t',
		'%r',
		'%m',
		'%=',
		'%{&filetype}',
		eventName .. " at " .. x .. " " .. y .. " W" .. Buffer.getWidth() .. " H:" .. Buffer.getHeight(),
	}, '')
end

Touch.init = function()
	-- create and focus buffer
	Touch.bufferId = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_buf_set_name(Touch.bufferId, "Abz")
	vim.api.nvim_set_current_buf(Touch.bufferId)

	-- read store into buffer
	local storeContent = File.readAll(os.getenv("HOME") .. '/.config/nvim/store.sh')

	if not storeContent then
		Log.err('Failed to load store for Touch')
		return nil
	end

	Buffer.setContent(Touch.bufferId, 0, -1, vim.split(storeContent, '\n'))
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
