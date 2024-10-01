Terminal = require("utils.terminal")
File = require("utils.file")
Package = require("utils.package")
Keyboard = require("utils.keyborad")
Io = require("io")

Notes = {}

Notes.excludeOs = {
	Terminal.TERMUX
}

Notes.getNotePathMap = function()
	local fileContent = File.readAll(NOTE_PATHS_FILE_PATH)

	if not fileContent then return {} end

	return vim.fn.json_decode(fileContent)
end

Notes.getNotePath = function()
	local notePathMap = Notes.getNotePathMap()
	local cwd = vim.fn.getcwd()

	if Table.hasKey(notePathMap,cwd) then
		return notePathMap[cwd]
	end

	local newNotePath = vim.fn.input('path:')

end

Notes.maps = {
	{
		mode = 'n',
		map = 'tn',
		to = function()
			Notes.getNotePath()
		end
	},
	{
		mode = 'n',
		map = 'né',
		to = function()

		end
	}
	-- TODO: alter path command
}



return Notes
