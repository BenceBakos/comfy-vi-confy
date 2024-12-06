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
		Log.log("Command failed, run manually: "..command)
		return
	end
end

Terminal.runIn = function(command,cwd)
	Terminal.run('mkdir -p '..cwd)
	return Terminal.run('cd '..cwd..' && '..command)
end

Terminal.runSync = function(command)
	local handle = io.popen(command)

	if handle then return handle:read("*a") end

	return nil
end

Terminal.getBinaryPath = function(binary)
	return Terminal.runSync('command -v '..binary)
end

Terminal.binaryExists = function(binary)
	return Terminal.getBinaryPath(binary) ~= ''
end

Terminal.runSyncIn = function(command,cwd)
	Terminal.run('mkdir -p '..cwd)
	return Terminal.run('cd '..cwd..' && '..command)
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

Terminal.install = function(package,os)
end

return Terminal
