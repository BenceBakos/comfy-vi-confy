-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- Key constants
vim.g.key_telescope_find_files = '<Leader>c'
vim.g.key_nav_down = '<C-j>'
vim.g.key_nav_up = '<C-k>'

-- Note: Most plugin-specific keymaps are defined in their plugin specs
-- This file contains general Neovim keymaps not tied to specific plugins

-- Add command aliases
vim.cmd([[
  command! Cgpath let @+=expand('%:p')
  command! Cpath let @+=expand('%')
  command! E e
  command! W w
  command! Wq wq
  command! WQ wq
  command! Edit edit
]])

-- Tab management
map('n', 'th', ':tabfirst<CR>', { silent = true })
map('n', 'tj', ':tabnext<CR>', { silent = true })
map('n', 'tk', ':tabprev<CR>', { silent = true })
map('n', 'tl', ':tablast<CR>', { silent = true })
map('n', 'té', ':vsplit<Space>', { noremap = true, silent = false })
map('n', 'tt', ':tabedit<Space>', { noremap = true, silent = false })
map('n', 'td', ':tabclose<CR>', { silent = true })
map('n', 'ti', ':tab ter<CR>', { silent = true })
map('n', 'to', ':botright vnew<Space><CR>:ter<CR>', { silent = true })

-- Special key mappings (qwertz layout)
map('n', 'é', '$', { noremap = true })
map('v', 'é', '$', { noremap = true })
map('n', 'á', ':noh<CR>', { noremap = true, silent = true })
map('n', ';', '$a;<ESC>', { noremap = true })

-- Indentation in visual mode
map('v', '<', '<gv', { noremap = true })
map('v', '>', '>gv', { noremap = true })

-- Terminal escape
map('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Auto-close pairs
map('i', '(', '()<Esc>i', { noremap = true })
map('i', '[', '[]<Esc>i', { noremap = true })
map('i', '{', '{}<Esc>i', { noremap = true })
map('i', "'", "''<Esc>i", { noremap = true })
map('i', '"', '""<Esc>i', { noremap = true })
map('i', '`', '``<Esc>i', { noremap = true })

-- Pair removal function
vim.cmd([[
  function! RemovePairs()
    let l:pairs = getline('.')[col('.')-2 : col('.')-1]
    if stridx('""''''()[]<>{}', l:pairs) % 2 == 0
      return "\<del>\<c-h>"
    else
      return "\<bs>"
    endif
  endfunction

  inoremap <expr> <bs> RemovePairs()
  imap <c-h> <bs>
]])

-- Window and buffer management
map('n', 'ó', ':q<CR>', { noremap = true, silent = true })
map('n', 'ö', ':noh<CR>', { noremap = true, silent = true })
map('n', '<Leader>h', '<C-w>h', { noremap = true })
map('n', '<Leader>j', '<C-w>j', { noremap = true })
map('n', '<Leader>k', '<C-w>k', { noremap = true })
map('n', '<Leader>l', '<C-w>l', { noremap = true })
map('n', '<Leader>é', '<C-w>l', { noremap = true })

-- File exploration
map('n', '-', ':Explore<CR>', { noremap = true, silent = true })

-- Quickfix navigation
map('n', 'ú', ':cn<CR>', { noremap = true, silent = true })
map('n', 'Ú', ':cp<CR>', { noremap = true, silent = true })
map('n', 'co', ':copen<CR>', { noremap = true, silent = true })

-- Get TODO items
map('n', 'gT', ':cexpr system("git grep -iF --line-number TODO")<CR>', { noremap = true, silent = true })

-- Registry access
map('n', 'ö', '"', { noremap = true })

-- Create functions for dynamic file paths
map('n', 'tu', function()
  vim.api.nvim_feedkeys(":tabedit " .. vim.fn.getcwd() .. '/', "n", true)
end, { silent = false })

map('n', 'tá', function()
  vim.api.nvim_feedkeys(":vsplit " .. vim.fn.getcwd() .. '/', "n", true)
end, { silent = false })