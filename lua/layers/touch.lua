Terminal = require("utils.terminal")
File = require("utils.file")

Touch = {}

Touch.separator = "#--------"

Touch.selectedLineSignName = "selectedLineSignName"
Touch.storeSignGroup = "storeSignGroup"

Touch.selectionCounter = 0

Touch.storeBufferName = "Store"
Touch.builderBufferName = "Builder"

Touch.storeBufferId = nil
Touch.builderBufferId = nil


Touch.leftReleaseHandler = {}

Touch.init = function()
	Touch.initStore()
	Touch.initBuilder()
	Touch.initLeftReleaseHandlers()

	-- define select sign
	vim.fn.sign_define(Touch.selectedLineSignName, { text = '■', texthl = "", linehl = "", numhl = "" })
end

Touch.initBuilder = function()
	Touch.storeBufferId = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_buf_set_name(Touch.storeBufferId, Touch.builderBufferName)
end

Touch.initStore = function()
	-- create and focus store buffer
	Touch.storeBufferId = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_buf_set_name(Touch.storeBufferId, Touch.storeBufferName)
	vim.api.nvim_set_current_buf(Touch.storeBufferId)

	-- read store into buffer
	local storeContent = File.readAll(os.getenv("HOME") .. '/.config/nvim/store.sh')

	if not storeContent then
		Log.err('Failed to load store for Touch')
		return nil
	end


	vim.api.nvim_buf_set_lines(Touch.storeBufferId, 0, -1, false, vim.split(storeContent, '\n'))
end

Touch.initLeftReleaseHandlers = function()
	Touch.leftReleaseHandler['<LeftRelease>'] = {}
	Touch.leftReleaseHandler['<LeftRelease>'][Touch.storeBufferId] = {
		selectStoreLine = function(col,row,winId,bufferId)
			
		end
		-- selectStoreSection
		-- selectedToBuilder
		-- selectBuilderLine
		-- selectBuilderSection
		-- cutBuilderSelected
		-- copyBuilderSelected
		-- pasteBuilderSelected
		-- manualEdit
		-- clearBuilder(make it a bit harder to do)
		-- execute(validate,store,exec in new terminal session)
		-- nextBuffer
		-- previousBuffer
		-- closeBuffer(only for terminals, stop execution!)
		-- edit executed(only in terminal buffer)
	}
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

			for _, handler in pairs(Touch.leftReleaseHandler[eventName][bufferId]) do
				handler(
					pointer.wincol,
					pointer.winrow,
					pointer.winid,
					bufferId)
			end
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

Touch.insertSign = function (row)
	Touch.selectionCounter = Touch.selectionCounter + 1
	vim.fn.sign_place(row, Touch.storeSignGroup, Touch.selectedLineSignName, Touch.storeBufferName, {lnum = row, priority = 1})
end

Touch.removeSign = function (row)
	Touch.selectionCounter = Touch.selectionCounter - 1
	vim.fn.sign_unplace(Touch.storeSignGroup, { buffer = Touch.storeBufferName, id = row })
end

Touch.removeAllSign = function (bufferName)
	Touch.selectionCounter = 0
	vim.fn.sign_unplace(Touch.storeSignGroup, { buffer = bufferName })
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
