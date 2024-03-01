require("os")
require("io")
Log = require("utils.log")

Terminal = {}

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


return Terminal
