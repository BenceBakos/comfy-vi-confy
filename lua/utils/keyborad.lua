Keyboard = {}

Keyboard.opts = { noremap = true, silent = true }
Keyboard.commandOpts = {}

Keyboard.map = function(mode, keys, cmd, opts)
	if not opts then
		opts = Keyboard.opts
	end

	if type(mode) == 'table' then
		for _, modeName in pairs(mode) do
			vim.api.nvim_set_keymap(modeName, keys, cmd, opts)
		end

		return
	end

	vim.api.nvim_set_keymap(mode, keys, cmd, opts)
end


Keyboard.mapFunction = function(mode, keys, callback, opts)
	if not opts then
		opts = Keyboard.opts
	end


	if type(mode) == 'table' then
		for _, modeName in pairs(mode) do
			vim.keymap.set(modeName, keys, "", { callback = callback })
		end

		return
	end

	vim.keymap.set(mode, keys, "", { callback = callback })
end


Keyboard.mapBuffer = function(buffer, mode, keys, cmd, opts)
	if not opts then
		opts = Keyboard.opts
	end

	if type(mode) == 'table' then
		for _, modeName in pairs(mode) do
			vim.api.nvim_buf_set_keymap(buffer, modeName, keys, cmd, opts)
		end

		return
	end

	vim.api.nvim_buf_set_keymap(buffer, mode, keys, cmd, opts)
end


Keyboard.mapFunctionBuffer = function(buffer, mode, keys, callback, opts)
	if not opts then
		opts = Keyboard.opts
	end

	vim.keymap.set(mode, keys, "", {
		callback = function()
			callback(buffer)
		end,
		buffer = buffer
	})
end


Keyboard.feed = function(keys, mode)
	local keysReplaced = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(keysReplaced, mode, true)
end

Keyboard.command = function(name, keys, commandOpts)
	if not commandOpts then
		commandOpts = Keyboard.commandOpts
	end

	vim.api.nvim_create_user_command(name, keys, commandOpts)
end

return Keyboard
