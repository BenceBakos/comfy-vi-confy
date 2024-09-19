
require('globals')

Log = require("utils.log")
File = require("utils.file")
Keyboard = require("utils.keyborad")
Terminal = require("utils.terminal")
Table = require("utils.table")


-- Package = require("utils.packages")

local modules = {
	'env',
	-- 'base'
}

Log.log('MODULES: ')
Log.log(modules)

local os = Terminal.getOs()
Log.log('OS: '..os)

-- INSTALL MISSING PACKAGES
local missingPackages = {}
for _,moduleName in ipairs(modules) do
	local module = require('modules.'..moduleName)

	Log.log('module:')
	Log.log('modules.'..moduleName)

	if Table.hasKey(module,'packages') then
		for _,packageName in ipairs(modules.packages) do
			local folderName = vim.split(packageName,'/')[2]
			if not Package.isInstalled(folderName) then
				missingPackages[#missingPackages + 1] = packageName
			end
		end
	end
end

if next(missingPackages) ~= nil then Package.install(missingPackages) end

-- HANDLE MISSING DEPENDENCIES
MISSING_DEPENDENCIES = ''
Keyboard.command('ShowMissingDependencies', ":lua print(MISSING_DEPENDENCIES)")

-- INIT MODULES
for _,moduleName in ipairs(modules) do
	local module = require('modules.'..moduleName)

	if Table.hasKey(module,'excludeOs') and Table.hasValue(module.excludeOs,os) then
		Log.log(moduleName..' - '..'exclude for os: '..os)
		goto continue
	end


	if Table.hasKey(module,'dependencyBinaries') and Table.hasKey(module.dependencyBinaries,os) then
		local dependencyList = vim.split(module.dependencyBinaries[os],' ')
		for _,binaryName in ipairs(dependencyList) do
			if not Terminal.binaryExists(binaryName) then 
				Log.log(moduleName..' - '..'skipping because binary is missing: '..binaryName)
				MISSING_DEPENDENCIES = MISSING_DEPENDENCIES..' '..binaryName
				goto continue
			end
		end
	end

	if Table.hasKey(module,'envCommands') and Table.hasKey(module.envCommands,os) then
		for _,command in ipairs(module.envCommands[os]) do
			Log.log(moduleName..' - '..'executing command: '..command)
			Terminal.runSync(command)
		end
	end

	if Table.hasKey(module,'init') then
		module.init()
	end


	if Table.hasKey(module,'options') and Table.hasKey(module.options,'g') then
		for optionName,optionValue in ipairs(module.options.g) do
			vim.g[optionName] = optionValue
		end
	end

	if Table.hasKey(module,'options') and Table.hasKey(module.options,'opt') then
		for optionName,optionValue in ipairs(module.options.opt) do
			vim.opt[optionName] = optionValue
		end
	end

	if Table.hasKey(module,'commands') then
		for commandName,commandValue in ipairs(module.commands) do
			Keyboard.command(commandName,commandValue)
		end
	end

	-- TODO: 
	-- - autocmds,maps,map functions
	-- - base model with the very basics I need

	::continue::
end
