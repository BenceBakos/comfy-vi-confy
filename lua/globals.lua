local Terminal = require("utils.terminal")

local M = {}

M.CONFIG_PATH = vim.fn.stdpath('config')
M.CONFIG_LUA_PATH = vim.fn.stdpath('config') .. '/lua'

M.NOTE_PATHS_FILE_PATH = vim.fn.stdpath('data') .. '/notePaths.json'

M.MODES = { 'n', 'i', 'v', 'c' }

M.OS = Terminal.getOs()

return M
