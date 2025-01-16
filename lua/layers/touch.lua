Terminal = require("utils.terminal")

Touch = {}

Touch.excludeOs = {
	-- Terminal.ARCH,
	-- Terminal.DEBIAN,
}

Touch.normalFeedCallback = function(keys)
	return function()
		vim.api.nvim_input(keys)
	end
end

-- row /cols
Touch.handlers = {
	{
		{
			-- top left
			['<LeftRelease>'] = function() Log.log('release 11') end, --command history, execute
			['<ScrollWheelUp>'] = function() Log.log('up 11') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 11') end,
		},
		{
			['<LeftRelease>'] = Touch.normalFeedCallback(':q<CR>'),
			['<ScrollWheelUp>'] = Touch.normalFeedCallback('<C-w>p'),
			['<ScrollWheelDown>'] = Touch.normalFeedCallback('<C-w>w'),
		},
		{
			-- top right
			['<LeftRelease>'] = Touch.normalFeedCallback('tt<CR>'), --todo populate default buffer/ call discover
			['<ScrollWheelUp>'] = Touch.normalFeedCallback('tk'),
			['<ScrollWheelDown>'] = Touch.normalFeedCallback('tj'),
		},
	},
	{
		{
			-- middle left
			['<LeftRelease>'] = Touch.normalFeedCallback(':w<CR>'),
			['<ScrollWheelUp>'] = Touch.normalFeedCallback('<C-r>'),
			['<ScrollWheelDown>'] = Touch.normalFeedCallback('u'),
		},
		{
			['<LeftRelease>'] = function() Log.log('p') end, --clipboard history, paste, clipboard-dev-connect
			['<ScrollWheelUp>'] = function() Log.log('up 12') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 22') end,
		},
		{
			-- middle right
			['<LeftRelease>'] = Touch.normalFeedCallback('<BR>'),
			['<ScrollWheelUp>'] = Touch.normalFeedCallback('>>'),
			['<ScrollWheelDown>'] = Touch.normalFeedCallback('<<'),
		},
	},
	{
		{
			-- bottom left
			['<LeftRelease>'] = function()
				if vim.api.nvim_get_mode().mode == 'v' then
					Touch.normalFeedCallback('y')
				end
				if vim.api.nvim_get_mode().mode == 'n' then
					Touch.normalFeedCallback('yy')
				end
			end,
			['<ScrollWheelUp>'] = Touch.normalFeedCallback('ddkp'),
			['<ScrollWheelDown>'] = Touch.normalFeedCallback('ddp'),
		},
		{
			-- bottom right
			['<LeftRelease>'] = Touch.normalFeedCallback('<CR>'),
			['<ScrollWheelUp>'] = Touch.normalFeedCallback('k'),
			['<ScrollWheelDown>'] = Touch.normalFeedCallback('j'),
		},
		{
			['<LeftRelease>'] = Touch.normalFeedCallback('v'),
			['<ScrollWheelUp>'] = Touch.normalFeedCallback('l'),
			['<ScrollWheelDown>'] = Touch.normalFeedCallback('h'),
		},
	}
}



Touch.init = function()
	vim.cmd [[highlight Cursor guifg=#FFFFFF guibg=#FF0000]]
end

Touch.getCellHandlers = function(dimensions)
	local row = math.ceil((dimensions.winrow / (dimensions.winRows / 3)))
	local col = math.ceil((dimensions.wincol / (dimensions.winCols / 3)))
	return Touch.handlers[row][col]
end


Touch.eventHandler = function(dimensions, eventName)
	Touch.getCellHandlers(dimensions)[eventName]();
end

Touch.frequency = 4
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
