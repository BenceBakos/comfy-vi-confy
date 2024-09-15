require("os")
require("io")
Log = require("utils.log")

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
	local result = handle:read("*a")
	return result
end

Terminal.runSyncIn = function(command,cwd)
	Terminal.run('mkdir -p '..cwd)
	return Terminal.run('cd '..cwd..' && '..command)
end

Terminal.getOs = function()
	if (Terminal.runSync('command -v pacman') ~= '') then
		return Terminal.ARCH
	end

	if (Terminal.runSync('command -v apt') == '/data/data/com.termux/files/usr/bin/apt') then
		return Terminal.TERMUX
	end

	if (Terminal.runSync('command -v apt') ~= '') then
		return Terminal.DEBIAN
	end

	Log.log('Can not determine OS! Defaulting to debian!')
	return Terminal.DEBIAN
end

Terminal.install = function(package)

end

return Terminal
