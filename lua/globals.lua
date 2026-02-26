Terminal = require("utils.terminal")

CONFIG_PATH = vim.fn.stdpath('config')
CONFIG_LUA_PATH = vim.fn.stdpath('config') .. '/lua'

NOTE_PATHS_FILE_PATH = vim.fn.stdpath('data') .. '/notePaths.json'

MODES = { 'n', 'i', 'v', 'c' }

OS = Terminal.getOs()
