Terminal = require("utils.terminal")
File = require("utils.file")

Touch = {}

Touch.excludeOs = {
	-- Terminal.DEBIAN,
	-- Terminal.ARCH,
}

Touch.maps = {

}

Touch.envCommands = {
	-- debian =  {'',''}
}

Touch.packages = {
}

Touch.events = {
	'<ScrollWheelUp>',
	'<ScrollWheelDown>',
	'<LeftMouse>',
	'<LeftDrag>',
	'<LeftRelease>',
	'<MiddleMouse>',
	'<MiddleDrag>',
	'<MiddleRelease>',
	'<RightMouse>',
	'<RightDrag>',
	'<RightRelease>',
	'<X1Mouse>',
	'<X1Drag>',
	'<X1Release>',
	'<X2Mouse>',
	'<X2Drag>',
	'<X2Release>'
}

Touch.init = function()
	for _,eventName in pairs(Touch.events) do
		table.insert(
			Touch.maps,
			{
				mode = 'n',
				map = eventName,
				to = function() Touch.logMouseClick(eventName) end,
				options = { noremap = true, silent = true },
			}
		)
	end
end

Touch.options = {
	g = {

	},
	opt = {
		mouse = 'a',
		mousefocus = true
	}
}

Touch.commands = {
	-- Cpath = ":let @+=expand('%')"
}

Touch.autocmds = {
	-- {events = { 'BufReadPost' }, settings ={ pattern = { '*' }, callback = function() end}}
}

Touch.index = 0;

Touch.logMouseClick = function(eventName)
	-- Get the mouse position
	local mouse_pos = vim.fn.getmousepos()
	local x = mouse_pos.wincol
	local y = mouse_pos.winrow

	-- Log the event name and coordinates
	vim.o.statusline = table.concat({
	  ' %t',
	  '%r',
	  '%m',
	  '%=',
	  '%{&filetype}',
	  eventName .. " at " .. x .. " " .. y,
	}, '')

	Touch.index = Touch.index + 1
	vim.api.nvim_buf_set_lines(0, Touch.index, -1, false, {eventName .. " at " .. x .. " " .. y  })

end


return Touch
