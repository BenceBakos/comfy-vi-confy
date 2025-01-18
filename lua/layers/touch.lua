Terminal = require("utils.terminal")

Touch = {}

Touch.excludeOs = {
	-- Terminal.ARCH,
	-- Terminal.DEBIAN,
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
			-- top left
			['<LeftRelease>'] = function() Log.log('release 11') end, --command history, execute
			['<ScrollWheelUp>'] = function() Log.log('up 11') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 11') end,
		},
		{
			['<LeftRelease>'] = Touch.feedCallback(':q<CR>'),
			['<ScrollWheelUp>'] = Touch.feedCallback('<C-w>p'),
			['<ScrollWheelDown>'] = Touch.feedCallback('<C-w>w'),
		},
		{
			-- top right
			['<LeftRelease>'] = Touch.feedCallback('tt<CR>'), --todo populate default buffer/ call discover
			['<ScrollWheelUp>'] = Touch.feedCallback('tk'),
			['<ScrollWheelDown>'] = Touch.feedCallback('tj'),
		},
	},
	{
		{
			-- middle left
			['<LeftRelease>'] = Touch.feedCallback(':w<CR>'),
			['<ScrollWheelUp>'] = Touch.feedCallback('<C-r>'),
			['<ScrollWheelDown>'] = Touch.feedCallback('u'),
		},
		{
			['<LeftRelease>'] = function() Log.log('press 12') end,
			['<ScrollWheelUp>'] = function() Log.log('up 12') end,
			['<ScrollWheelDown>'] = function() Log.log(' down 22') end,
		},
		{
			-- middle right
			['<LeftRelease>'] = Touch.feedCallback('<BS>'),
			['<ScrollWheelUp>'] = Touch.feedCallback('>>'),
			['<ScrollWheelDown>'] = function()
				vim.api.nvim_feedkeys('<<', 'n', true)
			end,
		},
	},
	{
		{
			-- bottom left
			['<LeftRelease>'] = function()
				if vim.api.nvim_get_mode().mode == 'v' then
					vim.api.nvim_feedkeys('y', 'n', true)
				end
				if vim.api.nvim_get_mode().mode == 'n' then
					vim.api.nvim_feedkeys('yy', 'n', true)
				end
			end,
			['<ScrollWheelUp>'] = Touch.feedCallback(':m .-2<CR>=='),
			['<ScrollWheelDown>'] = Touch.feedCallback(':m .+1<CR>=='),
		},
		{
			['<LeftRelease>'] = Touch.feedCallback('p'),
			['<ScrollWheelUp>'] = Touch.feedCallback('l'),
			['<ScrollWheelDown>'] = Touch.feedCallback('h'),
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
	local col = math.ceil((dimensions.screencol / (vim.o.columns / 3)))
	return Touch.handlers[row][col]
end


Touch.eventHandler = function(dimensions, eventName)
	Touch.getCellHandlers(dimensions)[eventName]();
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
