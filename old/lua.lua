
-- docs
-- 
-- -- Set capslock
-- setxkbmap -option caps:escape
--
-- -- Repeate last command
-- @:
--
-- -- Open new terminal tab
-- :tab ter
--
-- -- Jump paragraph:
-- { or }
--
-- -- Remove search selection
-- :noh
--
-- -- Go to last position
-- '.
--
-- -- Search folder and subfolders
-- :vim /pattern/ application/**
--
-- -- Next/previous finding
-- :cn :cp
--
-- -- Open file vertically
-- :vsp filename
-- 
-- -- Previous bufffer
-- ctrl + o
--
-- -- Autocomplete
-- ctrl+n (normal mode)
--
-- -- 


-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignore =  '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx'

-- next result
vim.keymap.set('n','ű',':cn<CR>zz')
vim.keymap.set('n','Ű',':cp<CR>zz')

-- textarea
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.expandtab = false 
vim.opt.tabstop=4 
vim.opt.shiftwidth=4 
vim.opt.softtabstop=-1
vim.opt.tabpagemax=2 
vim.opt.ruler = true 
vim.opt.numberwidth=6
vim.opt.cp=false

-- clipboard
vim.opt.clipboard="unnamedplus"

-- history
vim.opt.history=100 

-- command list autocomplete
vim.o.wildmode = "longest,full"

-- quickhand refinement
vim.api.nvim_create_user_command('W','w',{})
vim.api.nvim_create_user_command('Wq','wq',{})
vim.api.nvim_create_user_command('WQ','wq',{})

-- git 
vim.api.nvim_create_user_command('Gitpush', ':!git add . && git commit --all -m"<args>" && git push',{nargs=1})

-- edit configfile
vim.api.nvim_create_user_command('Editconfig',':tabedit ~/.config/nvim/init.lua',{})

-- open terminal in new tab,
vim.api.nvim_create_user_command('T', function() 
	vim.cmd[[:tabnew]]
	vim.cmd[[:tab ter]]
end,{})

-- open explorer in new tab
vim.api.nvim_create_user_command('X', function()
	vim.cmd[[:tabnew]]
	vim.cmd[[:Explore]]
end,{})

-- move to the end of line
vim.keymap.set({'n','v'},'é','$')

-- open file under cursor
vim.keymap.set('n','ú','<c-w>gf')

-- tabs
vim.keymap.set('n','th',':tabfirst<CR>')
vim.keymap.set('n','tj',':tabnext<CR>')
vim.keymap.set('n','tk',':tabprev<CR>')
vim.keymap.set('n','tl',':tablast<CR>')
vim.keymap.set('n','tt',':tabedit<Space>')
vim.keymap.set('n','tn',':tabnext<Space>')
vim.keymap.set('n','td',':tabclose<CR>')

-- brackets
vim.keymap.set({'i','n'},'"l','""<left>')
vim.keymap.set({'i','n'},"'l","''<left>")
vim.keymap.set({'i','n'},"`l","``<left>")
vim.keymap.set({'i','n'},"(l","()<left>")
vim.keymap.set({'i','n'},"[l","[]<left>")
vim.keymap.set({'i','n'},"{l","{}<left>")

vim.keymap.set({'i','n'},'"j','"<Enter><Enter>"<up><up><ESC>')
vim.keymap.set({'i','n'},"'j","'<Enter><Enter>'<up><up><ESC>")
vim.keymap.set({'i','n'},"`j","`<Enter><Enter>`<up><up><ESC>")
vim.keymap.set({'i','n'},"(j","(<Enter><Enter>)<up><up><ESC>")
vim.keymap.set({'i','n'},"[j","[<Enter><Enter>]<up><up><ESC>")
vim.keymap.set({'i','n'},"{j","{<Enter><Enter>}<up><up><ESC>")

vim.keymap.set({'i','n'},'"L','""<left>')
vim.keymap.set({'i','n'},"'L","''<left>")
vim.keymap.set({'i','n'},"`L","``<left>")
vim.keymap.set({'i','n'},"(L","()<left>")
vim.keymap.set({'i','n'},"[L","[]<left>")
vim.keymap.set({'i','n'},"{L","{}<left>")

vim.keymap.set({'i','n'},'"J','"<Enter><Enter>"<up><up><ESC>')
vim.keymap.set({'i','n'},"'J","'<Enter><Enter>'<up><up><ESC>")
vim.keymap.set({'i','n'},"`J","`<Enter><Enter>`<up><up><ESC>")
vim.keymap.set({'i','n'},"(J","(<Enter><Enter>)<up><up><ESC>")
vim.keymap.set({'i','n'},"[J","[<Enter><Enter>]<up><up><ESC>")
vim.keymap.set({'i','n'},"{J","{<Enter><Enter>}<up><up><ESC>")


-- close line with semicolons ;
vim.keymap.set('n',';','$a;<ESC>')

-- persitent cursor position
vim.api.nvim_create_autocmd(
    {'BufReadPost'},{
    pattern = {'*'},
    callback = function()
        -- don't apply to git messages
        if (vim.opt_local.filetype:get():match('commit') or vim.opt_local.filetype:get():match('rebase')) then return end
        -- get position of last saved edit
        local markpos = vim.api.nvim_buf_get_mark(0,'"')
        -- if in range, go there
        if (markpos[1] > 1) and (markpos[1] <= vim.api.nvim_buf_line_count(0)) then
            vim.api.nvim_win_set_cursor(0,{markpos[1],markpos[2]})
        end
    end
})

-- remove double symbols
vim.cmd [[
inoremap <expr> <bs> Remove_pair()
imap <c-h> <bs>

function Remove_pair() abort
  let pair = getline('.')[ col('.')-2 : col('.')-1 ]
  return stridx('""''''()[]<>{}', pair) % 2 == 0 ? "\<del>\<c-h>" : "\<bs>"
endfunction
]]


-- escape terminal mode
vim.keymap.set({'t','n'},'<Esc>','<C-\\><C-n>')

vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 3

-- netwr keymaps for tabs
vim.cmd[[
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    noremap <buffer> th  :tabfirst<CR>
	noremap <buffer> tj  :tabnext<CR>
	noremap <buffer> tk  :tabprev<CR>
	noremap <buffer> tl  :tablast<CR>
	noremap <buffer> tt  :tabedit<Space>
	noremap <buffer> tn  :tabnext<Space>
	noremap <buffer> tm  :tabm<Space>
	noremap <buffer> td  :tabclose<CR>
endfunction
]]

