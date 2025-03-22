-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- Constants
local INDENTATION = 2
local MAX_LINE_LENGTH = 100

-- Notes path - accessible to other modules
vim.g.notes_path = vim.env.NOTES_PATH or vim.fn.expand('~/notes')

--disable git blame by default
vim.g.gitblame_enabled = 0

-- Create notes directory if it doesn't exist
if vim.fn.isdirectory(vim.g.notes_path) == 0 then
  vim.fn.mkdir(vim.g.notes_path, "p")
end

-- Basic options
opt.shiftwidth = INDENTATION
opt.tabstop = INDENTATION
opt.expandtab = true
opt.smartindent = true
opt.clipboard = "unnamedplus"

-- UI options
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false
opt.termguicolors = true

-- Search options
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Performance options
opt.lazyredraw = true
opt.updatetime = 250
opt.timeoutlen = 300

-- File handling
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.fileencoding = "utf-8"


