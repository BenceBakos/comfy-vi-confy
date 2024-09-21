require('globals')

Log = require("utils.log")
File = require("utils.file")
Keyboard = require("utils.keyborad")
Terminal = require("utils.terminal")
Table = require("utils.table")

Main = {}

Main.layers = {
	'env',
	'base'
}

Main.init = function()
	-- Package = require("utils.packages")

	Log.log('LAYERS: ')
	Log.log(Main.layers)

	local os = Terminal.getOs()
	Log.log('OS: ' .. os)

	-- INSTALL MISSING PACKAGES
	local missingPackages = {}
	for _, layerName in pairs(Main.layers) do
		local layer = require('layers.' .. layerName)

		Log.log('layer:')
		Log.log('layers.' .. layerName)

		if Table.hasKey(layer, 'packages') then
			for _, packageName in pairs(Main.layers.packages) do
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
	for _, layerName in pairs(Main.layers) do
		local layer = require('layers.' .. layerName)

		-- OS EXCLUSION
		if Table.hasKey(layer, 'excludeOs') and Table.hasValue(layer.excludeOs, os) then
			Log.log(layerName .. ' - ' .. 'exclude for os: ' .. os)
			goto continue
		end

		-- DEPENDENCY BINARY EXCLUSION
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

		Main.initSection(layer, { 'envCommands', os }, function(key, value)
			Terminal.runSync(value)
		end)

		if Table.hasKey(layer, 'init') then
			layer.init()
		end

		Main.initSection(layer, { 'options', 'g' }, function(key, value)
			vim.g[key] = value
		end)

		Main.initSection(layer, { 'options', 'opt' }, function(key, value)
			vim.opt[key] = value
		end)

		Main.initSection(layer, 'commands', function(key, value)
			Keyboard.command(key, value)
		end)

		Main.initSection(layer, 'autocmds', function(key, value)
			vim.api.nvim_create_autocmd(value.events, value.settings)
		end)

		Main.initSection(layer, 'maps', function(key, value)
			local options = false

			if Table.hasKey(value, 'options') then options = value.options end

			Keyboard.map(value.mode, value.map, value.to, options)
		end)

		Main.initSection(layer, 'mapFunctions', function(key, value)
			local options = false

			if Table.hasKey(value, 'options') then options = value.options end

			Keyboard.mapFunction(value.mode, value.map, value.to, options)
		end)

		-- TODO:
		-- - plugin managger, plugins in general

		::continue::
	end
end

Main.initSection = function(layer, path, init)
	if type(path) == 'string' then
		if Table.hasKey(layer, path) then
			for key, value in pairs(layer[path]) do
				init(key, value)
			end
		end
		return nil
	end

	local embeddedValues = Table.getEmbeddedValue(layer, path)

	if embeddedValues then
		for key, value in pairs(embeddedValues) do
			init(key, value)
		end
		return nil
	end

	Log.err('ERROR: section value invalid for path:')
	Log.err(path)
	Log.err('in layer:')
	Log.err(layer)
end

Main.init()
