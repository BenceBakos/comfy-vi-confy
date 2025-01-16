Terminal = require("utils.terminal")
Keyboard = require("utils.keyborad")
Table = require("utils.table")
Tui = require("utils.tui")

Abz = {}

Abz.CONSTANTS_PATH = 'constants.json'
Abz.FUNCTIONS_PATH = 'functions.json'
Abz.SELECT_HISTORY_PATH = 'selectHistory.json'

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

Abz.selectHistory = {
	modules = {}, -- map it, order
	functions = {},
	constants = {},
}

Abz.init = function()
	if File.fileExists(File.getPersistnecyPath() .. Abz.CONSTANTS_PATH) then
		Abz.constants = File.loadTable(File.getPersistnecyPath() .. Abz.CONSTANTS_PATH)
	end

	if File.fileExists(File.getPersistnecyPath() .. Abz.FUNCTIONS_PATH) then
		Abz.functions = File.loadTable(File.getPersistnecyPath() .. Abz.FUNCTIONS_PATH)
	end

	if File.fileExists(File.getPersistnecyPath() .. Abz.SELECT_HISTORY_PATH) then
		Abz.selectHistory = File.loadTable(File.getPersistnecyPath() .. Abz.SELECT_HISTORY_PATH)
	end
end

Abz.addConstant = function()
	local value = Tui.prompt('Const Value: ')
	while not value do
		value = Tui.prompt('Const Value (' .. value .. ' taken or nil): ')
	end

	local name = Tui.prompt('Const Name: ')
	while not name or Table.hasKey(Abz.constants, name) do
		name = Tui.prompt('Const Name (' .. name .. ' taken or nil): ')
	end

	local description = Tui.prompt('Const Description: ')

	Abz.constants[name] = {
		name = name,
		description = description,
		value = value
	}

	File.storeTable(Abz.constants, File.getPersistnecyPath() .. Abz.CONSTANTS_PATH)
end

Abz.maps = {
	{
		mode = 'n',
		map = 'ű',
		to = function()
			Tui.view(true,{
				["11"] = {
					['<LeftRelease>'] = function (content,cell,eventName)
						Log.log(content)
						Log.log(cell)
						Log.log(eventName)
						Log.log('---')
						return nil
					end,
					['<ScrollWheelUp>'] = function (content,cell,eventName)
						Log.log(content)
						Log.log(cell)
						Log.log(eventName)
						Log.log('---')
						table.insert(content,'fuck mee')
						return content
					end
				},
				["32"] = {
					['<LeftRelease>'] = function (content,cell,eventName)
						Log.log(content)
						Log.log(cell)
						Log.log(eventName)
						Log.log('---')
					end,
					['<ScrollWheelDown'] = function (content,cell,eventName)
						Log.log(content)
						Log.log(cell)
						Log.log(eventName)
						Log.log('---')
					end
				},
			},{
				'my lines',
				'flies'
				})
		end,
		options = false
	},
}

Abz.autocmds = {

}

Abz.commands = {
	AddConstant = ":lua require('layers.abz').addConstant()",
}

return Abz
