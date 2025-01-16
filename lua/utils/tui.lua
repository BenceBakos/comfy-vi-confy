Terminal = require('utils.terminal')

Tui = {}

Tui.TERMUX_BUTTON_CODE_OK = -1
Tui.TERMUX_BUTTON_CODE_CANCEL = -2

Tui.prompt = function(label)
	if Terminal.isTermux() then
		local termuxInput = vim.fn.json_decode(
			Terminal.runSync('termux-dialog -t "' .. label .. '"')
		)

		if termuxInput.code == Tui.TERMUX_BUTTON_CODE_CANCEL then
			return nil
		end

		return termuxInput.text
	end

	return vim.fn.input(label)
end

Tui.view = function(isFloating, handlers, content)
	local buffer = vim.api.nvim_create_buf(false, true)
	local win = nil

	vim.bo[buffer].filetype = 'markdown'
	vim.api.nvim_buf_set_name(buffer, 'Selector-' .. buffer)

	if isFloating then
		win = vim.api.nvim_open_win(buffer, true, {
			relative = 'editor',
			width = vim.o.columns - 2,
			height = vim.o.lines - 22,
			row = 1,
			col = 1,
			border = 'rounded', -- You can use 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
		})

		vim.api.nvim_win_set_cursor(win, { 1, 1 })
	else
		vim.cmd('tabnew')
		vim.api.nvim_set_current_buf(buffer)
	end

	vim.api.nvim_buf_set_lines(buffer, 0, -1, false, content)

	local bufferMouseMaps = {}

	vim.bo[buffer].readonly = true
end

Tui.mapFunctionsToBuffer = function(buffer, bufferMouseMaps)
	for eventName, handlers in pairs(Main.mouseMaps) do
		if bufferMouseMaps[eventName] ~= nil then
			bufferMouseMaps[eventName] = Table.appendTables(handlers, bufferMouseMaps[eventName])
		else
			bufferMouseMaps[eventName] = handlers
		end
	end

	Main.initMouseEvents(bufferMouseMaps, buffer)
end

Tui.statusLineParams = {
}

Tui.updadteStatusLine = function(params)
	Tui.statusLineParams = Table.merge(Tui.statusLineParams,params)

	vim.o.statusline = table.concat({
		' %t',
		'%r',
		'%m',
		'%=',
		'%{&filetype}',
	}, '')
end

return Tui
