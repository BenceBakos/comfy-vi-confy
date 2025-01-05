Keyboard = {}

Keyboard.opts = { noremap = true, silent = true }
Keyboard.commandOpts = { }

Keyboard.map = function(mode, keys, cmd, opts)
	if not opts then
		opts = Keyboard.opts
	end

	vim.api.nvim_set_keymap(mode, keys, cmd, opts)
end


Keyboard.mapFunction = function(mode, keys, callback, opts)
	if not opts then
		opts = Keyboard.opts
	end

	vim.keymap.set(mode, keys, "", { callback = callback })
end


Keyboard.mapBuffer = function(buffer,mode, keys, cmd, opts)
	if not opts then
		opts = Keyboard.opts
	end

	vim.api.nvim_buf_set_keymap(buffer,mode, keys, cmd, opts)
end


Keyboard.mapFunctionBuffer = function(buffer,mode, keys, callback, opts)
	if not opts then
		opts = Keyboard.opts
	end

	vim.keymap.set(mode, keys, "", { callback = function ()
		callback(buffer)
	end,buffer=buffer })
end


Keyboard.feed=function(keys, mode)
	local keysReplaced = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(keysReplaced, mode, true)
end

Keyboard.command=function(name,keys,commandOpts)
	if not commandOpts then
		commandOpts  = Keyboard.commandOpts
	end

	vim.api.nvim_create_user_command(name,keys, commandOpts)
end

Keyboard.doubleCharactersOpen =  {"'",'"','`','(','[','{','<'}
Keyboard.doubleCharactersClose = {"'",'"','`',')',']','}','>'}

Keyboard.getCurrentChar = function ()
	local col = vim.api.nvim_win_get_cursor(0)[2] + 1
	local char = vim.api.nvim_get_current_line():sub(col, col) -- Maybe col-1
	return char
end

return Keyboard
