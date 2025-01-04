Terminal = require("utils.terminal")
Keyboard = require("utils.keyborad")

Abz = {}

-- name(key)
-- module(path form package.loaded,nil when complex)
-- description
-- tags(string array)
-- arguments
--    not nil when complex
--    ordered string list
-- body
--    not nil when complex
--    describes functions calling each other
--
Abz.functions = {}

-- name(module+name -> key)
-- module(path form package.loaded,nil when custom)
-- description
-- tags(string array)
-- value(not nil when custom)
--
Abz.constants = {}

-- Abz.getHistoryPath = function()
-- 	if Terminal.getOs() == Terminal.TERMUX then
-- 		return os.getenv("HOME") .. '/storage/shared/nvimCommandHistory/nvimCommandHistory.sh'
-- 	end
--
-- 	return os.getenv("HOME") .. '/nvimCommandHistory/nvimCommandHistory.sh'
-- end

Abz.selectHistory = {
	modules = {}, -- map it, order
	functions = {},
	constants = {},
}

Abz.init = function()

end

Abz.autocmds = {

}

Abz.maps = {}

return Abz
