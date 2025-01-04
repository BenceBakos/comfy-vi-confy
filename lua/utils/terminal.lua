require("os")
require("io")
Log = require("utils.log")
File = require("utils.file")

Terminal = {}

Terminal.DEBIAN = 'debian'
Terminal.ARCH = 'arch'
Terminal.TERMUX = 'termux'

Terminal.run = function(command)
	if not os.execute(command) then
		Log.log("Command failed, run manually: " .. command)
		return
	end
end

Terminal.runIn = function(command, cwd)
	Terminal.run('mkdir -p ' .. cwd)
	return Terminal.run('cd ' .. cwd .. ' && ' .. command)
end

Terminal.runSync = function(command)
	local handle = io.popen(command)

	if handle then return handle:read("*a") end

	return nil
end

Terminal.getBinaryPath = function(binary)
	return Terminal.runSync('command -v ' .. binary)
end

Terminal.binaryExists = function(binary)
	return Terminal.getBinaryPath(binary) ~= ''
end

Terminal.runSyncIn = function(command, cwd)
	Terminal.run('mkdir -p ' .. cwd)
	return Terminal.run('cd ' .. cwd .. ' && ' .. command)
end

Terminal.getOs = function()
	if (Terminal.getBinaryPath('pacman') ~= '') then
		return Terminal.ARCH
	end

	if File.fileExists('~/.termux') then
		return Terminal.TERMUX
	end

	return Terminal.DEBIAN
end

Terminal.isTermux = function()
	return Terminal.getOs() == Terminal.TERMUX
end


Terminal.startProcess = function(callback)
	local handle
	local stdin = vim.loop.new_pipe(false) -- Create a pipe for stdin
	local stdout = vim.loop.new_pipe(false) -- Create a pipe for stdout
	local stderr = vim.loop.new_pipe(false) -- Create a pipe for stderr

	handle = vim.loop.spawn("sh", {
		stdio = { stdin, stdout, stderr }, -- Use the stdin pipe
	}, function(code)
		stdin:close()
		stdout:close()
		stderr:close()
		handle:close()
		Log.err('Spawning sh process failed with code ' .. code)
	end)

	stdout:read_start(callback)

	return {
		handle = handle,
		stdin = stdin,
		stdout = stdout,
		stderr = stderr,
	}
end

Terminal.sendCommandToProcess = function(process, expression)
	local success, err = process.stdin:write(expression)
	if not success then
		Log.err("Error writing to stdin: " .. err)
	end
end

Terminal.closeProcess = function(process)
	process.stdin:close()
	process.stdout:close()
	process.stderr:close()
	process.handle:close()
end


return Terminal
