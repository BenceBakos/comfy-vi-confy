
require('globals')

Log = require("utils.log")
File = require("utils.file")
Keyboard = require("utils.keyborad")
Terminal = require("utils.terminal")
Table = require("utils.table")

-- Package = require("utils.packages")

local modules = {
	'test'
}

Log.log('MODULES: ')
Log.log(modules)

local os = Terminal.getOs()

Log.log('OS: '..os)

for moduleName in modules do
	local module = require(moduleName)

	if Table.hasKey(module,'excludeOs') and Table.hasValue(module.excludeOs,os) then
		goto continue
	end

	if Table.hasKey(module,'envCommands') then
		for command in module.envCommands do Terminal.runSync(command) end
	end

	if Table.hasKey(module,'packages') and Table.hasKey(module.packages,os) then
		Terminal.install(packages) --todo implement install, then continue with other params from Sample
	end


	::continue::
end
