Terminal = require("utils.terminal")
File = require("utils.file")
Buffer = require("utils.buffer")

Touch = {}

Touch.excludeOs = {
	-- Terminal.DEBIAN,
	-- Terminal.ARCH,
}

Touch.maps = {}

Touch.envCommands = {
	-- debian =  {'',''}
}

Touch.packages = {
}

Touch.events = {
	'<ScrollWheelUp>',
	'<ScrollWheelDown>',
	'<LeftMouse>',
	'<LeftRelease>',
	-- '<LeftDrag>',
	-- '<MiddleMouse>',
	-- '<MiddleDrag>',
	-- '<MiddleRelease>',
	-- '<RightMouse>',
	-- '<RightDrag>',
	-- '<RightRelease>',
	-- '<X1Mouse>',
	-- '<X1Drag>',
	-- '<X1Release>',
	-- '<X2Mouse>',
	-- '<X2Drag>',
	-- '<X2Release>'
}

Touch.components = {
	require('layers.touch.sampleComponent')
}

Touch.handleEvent = function(eventName)
	-- Get the mouse position
	local mouse_pos = vim.fn.getmousepos()
	local x = mouse_pos.wincol
	local y = mouse_pos.winrow

	Touch.logEvent(eventName,x,y)

	for _, component in pairs(Touch.components) do
		if (component.condition(eventName,x,y)) then
			component.controller(eventName,x,y)
		end

		component.render(eventName,x,y)
	end
end

Touch.buffer = nil

Touch.init = function()

	-- create and focus buffer
	Touch.buffer = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_buf_set_name(Touch.buffer, "Abz")
	vim.api.nvim_set_current_buf(Touch.buffer)

	for _,eventName in pairs(Touch.events) do
		table.insert(
			Touch.maps,
			{
				mode = 'n',
				map = eventName,
				to = function() Touch.handleEvent(eventName) end,
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

-- Touch.index = 0

Touch.logEvent = function(eventName,x,y)

	-- Log the event name and coordinates
	vim.o.statusline = table.concat({
	  ' %t',
	  '%r',
	  '%m',
	  '%=',
	  '%{&filetype}',
	  eventName .. " at " .. x .. " " .. y.." W"..Buffer.getWidth().." H:"..Buffer.getHeight(),
	}, '')

	-- Touch.index = Touch.index + 1
	-- vim.api.nvim_buf_set_lines(0, Touch.index, -1, false, {eventName .. " at " .. x .. " " .. y  })

end

Touch.autocmds = {
	-- {events = { 'BufReadPost' }, settings ={ pattern = { '*' }, callback = function() end}}
}




return Touch
