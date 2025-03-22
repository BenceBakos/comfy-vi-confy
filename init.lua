-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set up global configuration

-- Remap caps lock to escape if setxkbmap is available
local function has_setxkbmap()
  local handle = io.popen("command -v setxkbmap")
  if handle then
    local result = handle:read("*a")
    handle:close()
    return #result > 0
  end
  return false
end

if has_setxkbmap() then
  -- Don't break if command fails
  pcall(function()
    vim.fn.system("setxkbmap -option caps:escape")
  end)
end

-- Load config modules
require("config.options")
require("config.keymaps")

-- Load plugins using the simplified architecture
require("lazy").setup({
  -- Import plugin specifications from the plugins directory
  { import = "config.plugins" },
}, {
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})