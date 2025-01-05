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
