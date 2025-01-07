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

Tui.tableBrowser = function(elements, isFloating, actions)
	local buffer = vim.api.nvim_create_buf(false, true)
	local win = nil

	vim.bo[buffer].readonly = true

	vim.api.nvim_buf_set_name(buffer,'Selector-'..buffer)

	if isFloating then

		win = vim.api.nvim_open_win(buffer, true, {
			relative = 'editor',
			width = vim.o.columns - 2,
			height = vim.o.lines - 22,
			row = 1,
			col = 1,
			style = 'minimal',
			border = 'rounded', -- You can use 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
		})
		vim.api.nvim_set_current_win(win) --TODO: did not work
	else
		vim.cmd('tabnew')
		vim.api.nvim_set_current_buf(buffer)
	end


	-- - **make this whatever way possible**, and then figure how to make it more generic
	--     - selector method used kinda everywhere
	--     - multi level display
	--     - name, details(keep it multiline even if just a name)
	--     - disabled items
	-- - upadte select history
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

return Tui
