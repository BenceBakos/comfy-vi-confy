


" Capslock:
" setxkbmap -option caps:escape
" Repeat last command:
" @:
" Folding in md: 
" za
" Open new termian tab:
" :tab ter
" open file under cursor:
" gf
" Autocomplete:
" ctrl + n from file
"
" jump paragraphs: { and }
"you know when you are in hurry...
" remove search selection:
" :noh
" go to last posotion:
" '.
" edit remote folder
" sshfs -o IdentityFile=/home/babos/w/q/quantum.pem root@192.168.6.75:/ q675
" search:
" :vim /pattern/ application/**
" next/prev found: :cn :cp
"
"resume/continue coc list:
" :cocListResume
"open file vertically: 
":vsp filename
" previous buffer:
" ctrl + o 

:command W w
:command Wq wq
:command WQ wq

set nocp                    " 'compatible' is not set
filetype plugin on          " plugins are enabled

" GIT automations
com! -nargs=1 Gitpush : :!git add . && git commit --all -m"<args>" && git push

" edit THIS config in new tab
com! Editconfig : :tabedit ~/.config/nvim/init.vim

" file path to clipboard

function CopyPath()
	let @+=expand('%:p')
endfunction

function CopyFileName()
	let @+=expand('%:t')
endfunction

command! -nargs=0 CopyPath call CopyPath()
command! -nargs=0 CopyFileName call CopyFileName()

set number
set autoindent noexpandtab tabstop=4 shiftwidth=4 softtabstop=-1

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set breakindent
syntax on
set history=100 tabpagemax=2 clipboard=unnamedplus ruler numberwidth=6

set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
" syntax highlight for snippets in markdown
let g:markdown_fenced_languages = ['bash=sh', 'javascript', 'js=javascript', 'json=javascript', 'typescript', 'ts=typescript', 'php', 'html', 'css', 'py=python']

" turn hybrid line numbers on

"qwertz additions
map é $$
map á :
map ö :wqa<CR>
map ü :w<CR>
map ű :cn<CR>zz
map Ű :cp<CR>zz

" open file under cursor:
nmap ú <c-w>gf  


" tabs (https://stackoverflow.com/questions/6638290/how-to-make-shortcut-for-tabnew-tabn-tabp)
noremap th  :tabfirst<CR>
noremap tj  :tabnext<CR>
noremap tk  :tabprev<CR>
noremap tl  :tablast<CR>
noremap tt  :tabedit<Space>
noremap tn  :tabnext<Space>
noremap td  :tabclose<CR>

" disable arrow keys

inoremap <Up> <Nop>

inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" close brackets...
inoremap "l ""<left>
inoremap 'l ''<left>
inoremap `l ``<left>
inoremap (l ()<left>
inoremap [l []<left>
inoremap {l {}<left>

inoremap "j "<Enter><Enter>"<up><up><ESC>o
inoremap 'j '<Enter><Enter>'<up><up><ESC>o
inoremap `j `<Enter><Enter>`<up><up><ESC>o
inoremap {j {<Enter><Enter>}<up><up><ESC>o
inoremap (j (<Enter><Enter>)<up><up><ESC>o
inoremap [j [<Enter><Enter>]<up><up><ESC>o

inoremap "L ""<left>
inoremap 'L ''<left>
inoremap `L ``<left>
inoremap (L ()<left>
inoremap [L []<left>
inoremap {L {}<left>
 
inoremap "J "<Enter><Enter>"<up><up><ESC>o
inoremap 'J '<Enter><Enter>'<up><up><ESC>o
inoremap `J `<Enter><Enter>`<up><up><ESC>o
inoremap {J {<Enter><Enter>}<up><up><ESC>o
inoremap (J (<Enter><Enter>)<up><up><ESC>o
inoremap [J [<Enter><Enter>]<up><up><ESC>o


" close line with ;
map ; $a;<ESC>

"restore session (https://stackoverflow.com/questions/1642611/how-to-save-and-restore-multiple-different-sessions-in-vim#_=_)
function! MakeSession(overwrite)
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  if a:overwrite == 0 && !empty(glob(b:filename))
    return
  endif
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
if(argc() == 0)
  au VimEnter * nested :call LoadSession()
  au VimLeave * :call MakeSession(1)
else
  au VimLeave * :call MakeSession(0)
endif

" Remove double characters 
inoremap <expr> <bs> <sid>remove_pair()
imap <c-h> <bs>

function s:remove_pair() abort
  let pair = getline('.')[ col('.')-2 : col('.')-1 ]
  return stridx('""''''()[]<>{}', pair) % 2 == 0 ? "\<del>\<c-h>" : "\<bs>"
endfunction


" autocomplete setting up
filetype plugin on
au FileType php setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setl ofu=rubycomplete#Complete
au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
au FileType c setl ofu=ccomplete#CompleteCpp
au FileType css setl ofu=csscomplete#CompleteCSS

" md Hide and format markdown elements like **bold**
autocmd FileType markdown set conceallevel=2

" Allow netrw to remove non-empty local directories
"
let g:netrw_localrmdir='rm -r'


" Escape from terminal mode with ESC
:tnoremap <Esc> <C-\><C-n>

" Comment - Uncomment blocks
let s:comment_map = { 
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "go": '\/\/',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "v": '\/\/',
    \   "lua": '--',
    \   "scala": '\/\/',
    \   "php": '\/\/',
    \   "python": '#',
    \   "ruby": '#',
    \   "rust": '\/\/',
    \   "sh": '#',
    \   "desktop": '#',
    \   "fstab": '#',
    \   "conf": '#',
    \   "profile": '#',
    \   "bashrc": '#',
    \   "bash_profile": '#',
    \   "mail": '>',
    \   "eml": '>',
    \   "bat": 'REM',
    \   "ahk": ';',
    \   "vim": '"',
    \   "tex": '%',
    \ }

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " " 
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else 
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction

nnoremap cc :call ToggleComment()<cr>
vnoremap cc :call ToggleComment()<cr>


" netwr config
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 3


" open Explorer/netwr
nnoremap ő :Explore<cr>
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

nmap ó :tabnew<cr>:tab ter<CR>


" folding markdown
let g:markdown_folding = 1

com! -nargs=1 Makeitem : :!cd /home/babos/inventory && ./mkitem.sh <args>

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd!
    autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}


" Vlang
Plug 'cheap-glitch/vim-v'

call plug#end()


" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd :call CocAction('jumpDefinition', 'tabedit')<CR>
nmap <silent> gy :call CocAction('jumpTypeDefinition', 'tabedit')<CR>
nmap <silent> gi :call CocAction('jumpImplementation', 'tabedit')<CR>
nmap <silent> gr :call CocAction('jumpReferences', 'tabedit')<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

let mapleader = "," " map leader to comma

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=\ %F\ %{coc#status()}%{get(b:,'coc_current_function','')}


" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" run current shell script 
nnoremap <F9> :!%:p<Enter>

"The functions that will run when a buffer is entered
func! CallAtBufEnter()
    "for `gd` jump, vsp than jump
    nmap <buffer> gd :call CocAction('jumpDefinition', 'tabedit')<CR>
endfunc
autocmd BufEnter * call CallAtBufEnter()


map - :CocNext<cr>
map _ :CocPrev<cr>
