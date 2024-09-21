require('globals')

Log = require("utils.log")
File = require("utils.file")
Keyboard = require("utils.keyborad")
Terminal = require("utils.terminal")
Table = require("utils.table")


-- Package = require("utils.packages")

local layers = {
	'env',
	'base'
}

Log.log('LAYERS: ')
Log.log(layers)

local os = Terminal.getOs()
Log.log('OS: ' .. os)

-- INSTALL MISSING PACKAGES
local missingPackages = {}
for _, layerName in pairs(layers) do
	local layer = require('layers.' .. layerName)

	Log.log('layer:')
	Log.log('layers.' .. layerName)

	if Table.hasKey(layer, 'packages') then
		for _, packageName in pairs(layers.packages) do
			local folderName = vim.split(packageName, '/')[2]
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

-- INIT LAYERS
for _, layerName in pairs(layers) do
	local layer = require('layers.' .. layerName)

	if Table.hasKey(layer, 'excludeOs') and Table.hasValue(layer.excludeOs, os) then
		Log.log(layerName .. ' - ' .. 'exclude for os: ' .. os)
		goto continue
	end


	if Table.hasKey(layer, 'dependencyBinaries') and Table.hasKey(layer.dependencyBinaries, os) then
		local dependencyList = vim.split(layer.dependencyBinaries[os], ' ')
		for _, binaryName in pairs(dependencyList) do
			if not Terminal.binaryExists(binaryName) then
				Log.log(layerName .. ' - ' .. 'skipping because binary is missing: ' .. binaryName)
				MISSING_DEPENDENCIES = MISSING_DEPENDENCIES .. ' ' .. binaryName
				goto continue
			end
		end
	end

	if Table.hasKey(layer, 'envCommands') and Table.hasKey(layer.envCommands, os) then
		for _, command in pairs(layer.envCommands[os]) do
			Log.log(layerName .. ' - ' .. 'executing command: ' .. command)
			Terminal.runSync(command)
		end
	end

	if Table.hasKey(layer, 'init') then
		layer.init()
	end


	if Table.hasKey(layer, 'options') and Table.hasKey(layer.options, 'g') then
		for optionName, optionValue in pairs(layer.options.g) do
			vim.g[optionName] = optionValue
		end
	end

	if Table.hasKey(layer, 'options') and Table.hasKey(layer.options, 'opt') then
		for optionName, optionValue in pairs(layer.options.opt) do
			vim.opt[optionName] = optionValue
		end
	end

	if Table.hasKey(layer, 'commands') then
		for commandName, commandValue in pairs(layer.commands) do
			Keyboard.command(commandName, commandValue)
		end
	end

	if Table.hasKey(layer, 'autocmds') then
		for _, cmdValue in pairs(layer.autocmds) do
			vim.api.nvim_create_autocmd(cmdValue.events, cmdValue.settings)
		end
	end

	if Table.hasKey(layer, 'maps') then
		for _, mapping in pairs(layer.maps) do
			local options = false

			if Table.hasKey(mapping,'options') then options = mapping.options end

			Keyboard.map(mapping.mode, mapping.map, mapping.to, options)
		end
	end

	if Table.hasKey(layer, 'mapFunctions') then
		for _, mapping in pairs(layer.mapFunctions) do
			local options = false

			if Table.hasKey(mapping,'options') then options = mapping.options end

			Keyboard.mapFunction(mapping.mode, mapping.map, mapping.to, options)
		end
	end

	-- TODO:
	-- - move init into module and optimize code
	-- - plugin managger, plugins in general

	::continue::
end
