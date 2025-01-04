Terminal = require("utils.terminal")
Keyboard = require("utils.keyborad")

Abz = {}

-- Abz.getHistoryPath = function()
-- 	if Terminal.getOs() == Terminal.TERMUX then
-- 		return os.getenv("HOME") .. '/storage/shared/nvimCommandHistory/nvimCommandHistory.sh'
-- 	end
--
-- 	return os.getenv("HOME") .. '/nvimCommandHistory/nvimCommandHistory.sh'
-- end

Abz.init = function()
	-- local process = Terminal.startProcess(function(err, data)
	-- 	if err then
	-- 		print("Error reading stdout: " .. err)
	-- 		return
	-- 	end
	-- 	if data then
	-- 		Log.log("Output: " .. data)
	-- 	end
	-- end)
	--
	-- Terminal.sendCommandToProcess(process,"ls -la\n")
	--
	-- Terminal.sendCommandToProcess(process,"cd ..")
	-- Terminal.sendCommandToProcess(process,"\n")
	--
	-- Terminal.sendCommandToProcess(process,"ls\n")
end

Abz.autocmds = {

}

Abz.maps = { }

-- Abz.analyzeExpression = function (expression)
-- TYPES TO SUPPORT
-- - Path
-- - Ip
-- - Domain
-- - Number
-- - Flag
-- - Switch
-- - String
-- iterate each type in order, execute test method
--
-- end

-- Abz.addToGraph = function (currentNode,expression)
-- analyse expression
-- end

return Abz
