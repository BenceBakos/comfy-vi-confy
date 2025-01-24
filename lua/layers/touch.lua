Terminal = require("utils.terminal")

Touch = {}

Touch.excludeOs = {
	-- Terminal.ARCH,
	-- Terminal.DEBIAN,
}

Base.options = {
	opt = {
		colorcolumn = tostring(math.floor((vim.o.columns / 3)))
	}
}


Touch.maps = {
	{ mode = 'n', map = 'k', to = 'kzz', options = { noremap = false } },
	{ mode = 'n', map = 'j', to = 'jzz', options = { noremap = false } },
}

Touch.init = function()
	vim.opt.guicursor = "n-v-c:block-Cursor"
	vim.cmd [[highlight Cursor guifg=#FFFFFF guibg=#FF0000]]
end


Touch.feedCallback = function(keys)
	return function()
		vim.api.nvim_input(keys)
	end
end

-- row /cols
Touch.handlers = {
	{
		{
			-- top right
			['<LeftRelease>'] = Touch.feedCallback(':HomeScreen<CR>'), --todo populate default buffer/ call discover
			['<ScrollWheelUp>'] = Touch.feedCallback('tk'),
			['<ScrollWheelDown>'] = Touch.feedCallback('tj'),
		},
		{
			-- bottom right
			['<LeftRelease>'] = Touch.feedCallback('<CR>'),
			['<ScrollWheelUp>'] = Touch.feedCallback('j'),
			['<ScrollWheelDown>'] = Touch.feedCallback('k'),
		},
	},
	{
		{
			['<LeftRelease>'] = Touch.feedCallback(':q<CR>'),
			['<ScrollWheelUp>'] = Touch.feedCallback('<C-w>p'),
			['<ScrollWheelDown>'] = Touch.feedCallback('<C-w>w'),
		},
		{
			['<LeftRelease>'] = Touch.feedCallback('<BS>'),
			['<ScrollWheelUp>'] = Touch.feedCallback('l'),
			['<ScrollWheelDown>'] = Touch.feedCallback('h'),
		},
	},
	{
		{
			-- top right
			['<LeftRelease>'] = Touch.feedCallback(':HomeScreen<CR>'), --todo populate default buffer/ call discover
			['<ScrollWheelUp>'] = Touch.feedCallback('tk'),
			['<ScrollWheelDown>'] = Touch.feedCallback('tj'),
		},
		{
			-- bottom right
			['<LeftRelease>'] = Touch.feedCallback('<CR>'),
			['<ScrollWheelUp>'] = Touch.feedCallback('j'),
			['<ScrollWheelDown>'] = Touch.feedCallback('k'),
		},
	}
}

Touch.getCellHandlers = function(dimensions)
	local row = math.ceil((dimensions.screenrow / (vim.o.lines / 3)))
	local col = math.ceil((dimensions.screencol / (vim.o.columns / 3))) - 1

	if col == 0 then return end

	return Touch.handlers[row][col]
end


Touch.eventHandler = function(dimensions, eventName)
	local handlers = Touch.getCellHandlers(dimensions)
	if handlers then handlers[eventName]() end
end

Touch.frequency = 2
Touch.frequencyTimeout = 0.3

Touch.scrollUpTimeStamp = 0
Touch.scrollUpCounter = 0

Touch.scrollDownTimeStamp = 0
Touch.scrollDownCounter = 0

Touch.mouseMaps = {

	['<ScrollWheelUp>'] = { function(dimensions, eventName)
		if os.clock() > Touch.scrollUpTimeStamp + Touch.frequencyTimeout then
			Touch.scrollUpTimeStamp = os.clock()
			Touch.scrollUpCounter = 0
		end

		Touch.scrollUpCounter = Touch.scrollUpCounter + 1

		if Touch.scrollUpCounter == Touch.frequency then
			Touch.scrollUpCounter = 0
			Touch.eventHandler(dimensions, eventName)
		end
	end },

	['<ScrollWheelDown>'] = { function(dimensions, eventName)
		if os.clock() > Touch.scrollDownTimeStamp + Touch.frequencyTimeout then
			Touch.scrollDownTimeStamp = os.clock()

			Touch.scrollDownCounter = 0
		end

		Touch.scrollDownCounter = Touch.scrollDownCounter + 1

		if Touch.scrollDownCounter == Touch.frequency then
			Touch.scrollDownCounter = 0
			Touch.eventHandler(dimensions, eventName)
		end
	end },
	['<LeftRelease>'] = { Touch.eventHandler }

}

return Touch
