Terminal = require("utils.terminal")

CONFIG_PATH = '~/.config/nvim'
CONFIG_LUA_PATH = '~/.config/nvim/lua'

NOTE_PATHS_FILE_PATH = vim.fn.stdpath('data') .. '/notePaths.json'

OS = Terminal.getOs()
