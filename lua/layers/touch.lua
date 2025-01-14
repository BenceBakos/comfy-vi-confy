Terminal = require("utils.terminal")

Touch = {}

-- row /cols
Touch.handlers = {
	{
		{
			-- top left
			['<LeftRelease>'] = function() Log.log('release 11') end,
			['<ScrollWheelUp>'] = function() Log.log('up 11') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 11') end,
		},
		{
			['<LeftRelease>'] = function() Log.log('release 12') end,
			['<ScrollWheelUp>'] = function() Log.log('up 12') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 12') end,
		},
		{
			-- top right
			['<LeftRelease>'] = function() Log.log('release 13') end,
			['<ScrollWheelUp>'] = function() Log.log('up 13') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 13') end,
		},
	},
	{
		{
			-- middle left
			['<LeftRelease>'] = function() Log.log('release 21') end,
			['<ScrollWheelUp>'] = function() Log.log('up 21') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 21') end,
		},
		{
			['<LeftRelease>'] = function() Log.log('release 22') end,
			['<ScrollWheelUp>'] = function() Log.log('up 12') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 22') end,
		},
		{
			-- middle right
			['<LeftRelease>'] = function() Log.log('release 23') end,
			['<ScrollWheelUp>'] = function() Log.log('up 23') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 23') end,
		},
	},
	{
		{
			-- bottom left
			['<LeftRelease>'] = function() Log.log('release 31') end,
			['<ScrollWheelUp>'] = function() Log.log('up 31') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 31') end,
		},
		{
			['<LeftRelease>'] = function() Log.log('release 32') end,
			['<ScrollWheelUp>'] = function() Log.log('up 32') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 32') end,
		},
		{
			-- bottom right
			['<LeftRelease>'] = function() Log.log('release 33') end,
			['<ScrollWheelUp>'] = function() Log.log('up 33') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 33') end,
		},
	}
}

Touch.excludeOs = {
	-- Terminal.ARCH,
	-- Terminal.DEBIAN,
}

Touch.init = function()

end

Touch.getCellHandlers = function(dimensions)
	local row = math.ceil((dimensions.winrow / (dimensions.winRows / 3)))
	local col = math.ceil((dimensions.wincol / (dimensions.winCols / 3)))
	return Touch.handlers[row][col]
end


Touch.eventHandler = function(dimensions, eventName)
	Touch.getCellHandlers(dimensions)[eventName]();
end

Touch.frequency = 6
Touch.frequencyTimeout = 0.3

Touch.scrollUpTimeStamp = 0
Touch.scrollUpCounter = 0

Touch.scrollDownTimeStamp = 0
Touch.scrollDownCounter = 0

Touch.mouseMaps = {
	['<ScrollWheelUp>'] = { function(dimensions, eventName)
		if os.clock() > Touch.scrollUpTimeStamp + Touch.frequencyTimeout then
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

Touch.hwae = {
	function(dimensions)
		if dimensions.wincol > (dimensions.winCols * 0.9) and dimensions.winrow < (dimensions.winRows * 0.1) then
			vim.cmd('q!')
		end
	end,
}


return Touch
