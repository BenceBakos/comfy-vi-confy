Log = require("utils.log")
File = require("utils.file")
Keyboard = require("utils.keyborad")
Terminal = require("utils.terminal")
Table = require("utils.table")
Package = require("utils.package")

Main = {}

Main.mouseMaps = {}
Main.mouseMaps['<LeftRelease>'] = {}
Main.mouseMaps['<ScrollWheelUp>'] = {}
Main.mouseMaps['<ScrollWheelDown>'] = {}


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
		path = { 'options', 'wo' },
		init = function(key, value)
			vim.wo[key] = value
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

			if type(value.to) == 'string' then
				Keyboard.map(value.mode, value.map, value.to, options)
			else
				Keyboard.mapFunction(value.mode, value.map, value.to, options)
			end
		end
	},
	{
		path = 'mouseMaps',
		init = function(key, value)
			Main.mouseMaps[key] = Table.appendTables(
				Main.mouseMaps[key],
				value
			)
		end
	},
}

Main.init = function(layers)
	Log.log('LAYERS: ')
	Log.log(layers)
	Log.log('OS: ' .. OS)

	-- INSTALL MISSING PACKAGES
	local missingPackages = {}
	for _, layerName in pairs(layers) do
		local layer = require('layers.' .. layerName)

		if Table.hasKey(layer, 'packages') and not (Table.hasKey(layer, 'excludeOs') and Table.hasValue(layer.excludeOs, OS)) then
			for _, packageName in pairs(layer.packages) do
				local folderName = vim.split(packageName, '/')[2]
				if not Package.isInstalled(folderName) then
					missingPackages[#missingPackages + 1] = packageName
				end
			end
		end
	end

	if next(missingPackages) ~= nil then Package.install(missingPackages) end

	-- INIT LAYERS
	for _, layerName in pairs(layers) do
		local layer = require('layers.' .. layerName)

		if not (Table.hasKey(layer, 'excludeOs') and Table.hasValue(layer.excludeOs, OS)) then
			for _, section in ipairs(Main.sections) do
				Main.initSection(layer, section.path, section.init)
			end
		end
	end

	-- INIT MOUSE EVENTS
	for eventName, handlers in pairs(Main.mouseMaps) do
		Keyboard.mapFunction('n', eventName, function()
			local dimensions = Main.getDimensions()

			Main.logEvent(
				eventName,
				dimensions.wincol,
				dimensions.winrow,
				dimensions.winid
			)

			for _, handler in pairs(handlers) do
				handler(dimensions)
			end
		end, {
			mode = 'n',
			map = eventName,
			to = { noremap = true, silent = true },
		})
	end
end

Main.initSection = function(layer, path, init)
	if Table.hasKey(layer, path) and type(layer[path]) == "function" then
		return layer[path]()
	end

	if type(path) == 'string' then
		if Table.hasKey(layer, path) then
			for key, value in pairs(layer[path]) do
				local status = init(key, value)
				if status == false and status ~= nil then return false end
			end
		end
		return true
	end

	local embeddedValues = Table.getEmbeddedValue(layer, path)
	if embeddedValues then
		for key, value in pairs(embeddedValues) do
			local status = init(key, value)
			if status == false and status ~= nil then return false end
		end
		return true
	end
end


Main.getDimensions = function()
	local pointer = vim.fn.getmousepos()

	return Table.merge(pointer, {
		winRows = vim.api.nvim_win_get_height(pointer.winid),
		winCols = vim.api.nvim_win_get_width(pointer.winid),
	})
end

Main.logEvent = function(eventName, col, row, winId)
	-- Log the event name and coordinates
	vim.o.statusline = table.concat({
		' %t',
		'%r',
		'%m',
		'%=',
		'%{&filetype}',
		eventName ..
		" at " ..
		col ..
		" " ..
		row ..
		" W" ..
		vim.api.nvim_win_get_width(winId) ..
		" H:" .. vim.api.nvim_win_get_height(winId),
	}, '')
end



return Main
