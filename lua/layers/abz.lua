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
end

Abz.autocmds = {
}

Abz.maps = {}

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
