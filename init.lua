require('globals')

Log = require("utils.log")
File = require("utils.file")
Keyboard = require("utils.keyborad")
Terminal = require("utils.terminal")
Table = require("utils.table")

Main = {}

Main.layers = {
	'env',
	'base',
	-- all init section tables(handle fn's in it as well)
	-- 'ide',
	--IDE or separate it? Get the most out, smallest possible layers, and one shall not depend on the other
	-- git tab open fast (lazygit, or just terminal)
	-- note tab open fast
}

Main.sections = {
	{
		path = 'excludeOs',
		init = function(key, value)
			if value == OS then return false end
		end
	},
	{
		path = { 'dependencyBinaries', OS },
		init = function(key, value)
			if not Terminal.binaryExists(value) then
				return false
			end
		end
	},
	{
		path = { 'envCommands', OS },
		init = function(key, value)
			Terminal.runSync(value)
		end
	},
	{
		path = 'init',
		init = function(key, value)
			value()
		end
	},
	{
		path = { 'options', 'g' },
		init = function(key, value)
			vim.g[key] = value
		end
	},
	{
		path = { 'options', 'opt' },
		init = function(key, value)
			vim.opt[key] = value
		end
	},
	{
		path = 'commands',
		init = function(key, value)
			Keyboard.command(key, value)
		end
	},
	{
		path = 'autocmds',
		init = function(key, value)
			vim.api.nvim_create_autocmd(value.events, value.settings)
		end
	},
	{
		path = 'maps',
		init = function(key, value)
			local options = false
			if Table.hasKey(value, 'options') then options = value.options end
			Keyboard.map(value.mode, value.map, value.to, options)
		end
	},
	{
		path = 'mapFunctions',
		init = function(key, value)
			local options = false
			if Table.hasKey(value, 'options') then options = value.options end
			Keyboard.mapFunction(value.mode, value.map, value.to, options)
		end
	},
}

Main.init = function()
	-- Package = require("utils.packages")

	Log.log('LAYERS: ')
	Log.log(Main.layers)

	Log.log('OS: ' .. OS)

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

		for _,section in ipairs(Main.sections) do
			Main.initSection(layer, section.path, section.init)
		end
	end
end

Main.initSection = function(layer, path, init)
	if type(path) == 'string' then
		if Table.hasKey(layer, path) then
			for key, value in pairs(layer[path]) do
				if not init(key, value) then return false end
			end
		end
		return true
	end

	local embeddedValues = Table.getEmbeddedValue(layer, path)
	if embeddedValues then
		for key, value in pairs(embeddedValues) do
			if not init(key, value) then return false end
		end
		return true
	end

	if Table.hasKey(layer, path) and type(layer[path]) == "function" then
		return layer[path]()
	end
end

Main.init()
