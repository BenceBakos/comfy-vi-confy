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

Tui.table = function(t, leafCallback, openInCurrent)
	Tui.tree(function(path, moveKey)
		if moveKey then table.insert(path, moveKey) end

		if not moveKey and #path == 0 and type(t) == 'string' then
			if leafCallback then
				leafCallback(t)
			end
			return t
		end

		if not moveKey and #path ~= 0 then table.remove(path) end

		if #path == 0 then return t end

		local value = Table.traversePath(t, path)

		if type(value) == 'string' then
			if leafCallback then
				leafCallback(value)
			end
			return nil
		end

		return value
	end, openInCurrent)
end

Tui.tree = function(getChildrenCallback, openInCurrent)
	local buffer = vim.api.nvim_create_buf(false, true)

	if not openInCurrent then
		vim.cmd('tabnew')
	end
	vim.api.nvim_set_current_buf(buffer)
	vim.api.nvim_buf_set_name(buffer, 'Table-' .. buffer)

	local path = {}

	Tui.writeToReadonlyBuffer(buffer, Tui.renderTable(getChildrenCallback(path, nil)))

	Keyboard.mapFunctionBuffer(buffer, 'n', '<CR>', function()
		local newItems = getChildrenCallback(path, string.match(vim.fn.getline(vim.fn.line('.')), "([^:]+)"))

		if not newItems then
			table.remove(path)
			return
		end

		Tui.writeToReadonlyBuffer(buffer, Tui.renderTable(newItems))
	end)

	local handleBack = function()
		Tui.writeToReadonlyBuffer(buffer, Tui.renderTable(getChildrenCallback(path, nil)))
	end

	Keyboard.mapFunctionBuffer(buffer, 'n', '<BS>', handleBack)
	Keyboard.mapFunctionBuffer(buffer, 'n', '-', handleBack)
end

Tui.renderTable = function(t)
	local lines = {}

	for key, value in pairs(t) do
		table.insert(lines, key .. ': ' .. string.gsub(Tui.serializeValue(value), '\r\n', ' '))
	end

	return lines
end

Tui.serializeValue = function(v)
	if type(v) == "table" then v = vim.fn.json_encode(v) end

	if type(v) == "boolean" then v = tostring(v) end

	return v
end

Tui.writeToReadonlyBuffer = function(buffer, content)
	vim.bo[buffer].readonly = false
	vim.api.nvim_buf_set_lines(buffer, 0, -1, false, content)
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
	Tui.statusLineParams = Table.merge(Tui.statusLineParams, params)

	vim.o.statusline = table.concat({
		' %t',
		'%r',
		'%m',
		'%=',
		'%{&filetype}',
	}, '')
end

return Tui
