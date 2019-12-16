﻿filetype off

if has('kaoriya')
    let g:no_vimrc_example=0
    let g:vimrc_local_finish=1
    let g:gvimrc_local_finish=1

	"$VIM/plugins/kaoriya/autodate.vim
	let plugin_autodate_disable  = 1
	"$VIM/plugins/kaoriya/cmdex.vim
	let plugin_cmdex_disable     = 1
	"$VIM/plugins/kaoriya/dicwin.vim
	let plugin_dicwin_disable    = 1
	"$VIMRUNTIME/plugin/format.vim
	let plugin_format_disable    = 1
	"$VIM/plugins/kaoriya/hz_ja.vim
	let plugin_hz_ja_disable     = 1
	"$VIM/plugins/kaoriya/scrnmode.vim
	let plugin_scrnmode_disable  = 1
	"$VIM/plugins/kaoriya/verifyenc.vim
	let plugin_verifyenc_disable = 1
endif

"Plugin managed by dein.vim
"installing directory
let s:dein_dir = expand('~/vimfiles/dein')
" dir of dein.vim
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

"download dein.vim if there's no dein.vim
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

"dein.vim settings
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    "create plugins list file using TOML format beforehand
    let g:rc_dir = expand('~/dotfiles')
    let s:toml = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

    "read and cache the toml files
    call dein#load_toml(s:toml, {'lazy':0})
    call dein#load_toml(s:lazy_toml, {'lazy':1})

    "end the setting
    call dein#end()
    call dein#save_state()
endif

"install if there are plugins not installed
if dein#check_install()
    call dein#install()
endif

"set backup folders
set undodir=$HOME/vimtmp/undo
set backupdir=$HOME/vimtmp/bk
set directory=$HOME/vimtmp/swap

"colorscheme
" deopleteのポップアップ色の変更
augroup colorSchemeGroup
    autocmd!
    autocmd ColorScheme * highlight Pmenu ctermfg=255 ctermbg=55 guifg=#ffffff guibg=#3c2ba0
    autocmd ColorScheme * highlight PmenuSel ctermfg=255 ctermbg=27 guifg=#ffffff guibg=#4174f4

    " カーソル行,列の色
    set cursorline
    autocmd ColorScheme * highlight CursorLine guibg=#28516f

    autocmd ColorScheme * highlight Visual ctermbg=244 guibg=#646464
    autocmd ColorScheme * highlight LineNr ctermbg=12 guifg=#b0c4de
    autocmd ColorScheme * highlight Comment ctermfg=12 guifg=#34a4eb cterm=NONE gui=NONE
    autocmd ColorScheme * highlight IncSearch ctermfg=0 ctermbg=226 guifg=#000000 guibg=#ffff00
    autocmd ColorScheme * highlight Search ctermfg=0 ctermbg=42 guifg=#000000 guibg=#66cdaa
    autocmd ColorScheme * highlight VertSplit ctermfg=2 ctermbg=2 guifg=#1c47b2 guibg=#1c47b2
augroup END

colorscheme cobalt2
syntax on

"about search
set hlsearch
set ignorecase "search both upper/lower case
set smartcase "distinguish upper/lower if search word include upper

"completion of parentheses
imap [ []<left>
imap ( ()<left>
imap { {}<left>
" imap < <><left>

"map jj to Esc
" inoremap <silent> jj <Esc>:<C-u>w<CR>
" cnoremap <silent> jj <Esc>:<C-u>w<CR>
" inoremap <silent> ｊｊ <Esc>:<C-u>w<CR>
" cnoremap <silent> ｊｊ <Esc>:<C-u>w<CR>
inoremap <silent> jj <Esc>
cnoremap <silent> jj <Esc>
inoremap <silent> ｊｊ <Esc>
cnoremap <silent> ｊｊ <Esc>
tnoremap <silent> jj <C-\><C-n>

imap <C-j> <esc>

"key bindings of Space + another
let mapleader = "\<Space>"
noremap <Leader>v g0vg$h
noremap <Leader>d g0vg$hx
noremap <Leader>y g0vg$hy

noremap <Leader>gv 0v$h
noremap <Leader>gd 0v$hx
noremap <Leader>gy 0v$hy

"space + h/l : move to beginning/end of the line
noremap <Leader>h g^
noremap <Leader>l g$
vnoremap <Leader>l g$h

noremap <Leader>gh ^
noremap <Leader>gl $
vnoremap <Leader>gl $h

"move to the bracket counterpart
noremap <Leader>b %

"tab
set tabstop=4 "set indent to four spaces
set autoindent
set expandtab
set shiftwidth=4

"command line mode
set wildmenu
set wildmode=longest:full,full
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-Space>h <Home>
cnoremap <C-Space><C-h> <Home>
cnoremap <C-Space>l <End>
cnoremap <C-Space><C-l> <End>
cnoremap <C-d> <Del>

"fzf
nnoremap <silent> ,f :GFiles<CR>
nnoremap <silent> ,F :GFiles?<CR>
nnoremap <silent> ,b :Buffers<CR>
nnoremap <silent> ,l :BLines<CR>
nnoremap <silent> ,h :History<CR>
nnoremap <silent> ,c :History:<CR>

" Using floating windows of Neovim to start fzf
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'

  function! FloatingFZF()
    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.6)
    let opts = { 'relative': 'editor',
               \ 'row': (&lines - height) / 2,
               \ 'col': (&columns - width) / 2,
               \ 'width': width,
               \ 'height': height }

    let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    call setwinvar(win, '&winhighlight', 'Pmenu')
    call nvim_win_set_option(win, 'winblend', 30)
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

"etc.
set ruler
set number "display line number
set title "display file name
set showmatch "show corresponding bracket
set showcmd
set clipboard=unnamed
set mouse=a
set iminsert=0
set imsearch=-1
set incsearch
set t_Co=256
set wrap
set breakindent
set linebreak
set virtualedit+=block "enable to select place w/o character in <C-v> mode
set matchpairs+=<:>
set belloff=all
set noshowmode
set conceallevel=0
set ambiwidth=single
set hidden
set scrolloff=1
let g:indentLine_char = '¦'
noremap j gj
noremap k gk
noremap gj j
noremap gk k

augroup etcSettingsGroup
    autocmd!
    autocmd BufRead,BufNewFile *.toml set filetype=conf
    autocmd QuickFixCmdPost *grep* cwindow
augroup END

"always search in very magic mode
nnoremap / /\v

"lightline
let s:lightline_colorscheme = 'wombat'
let g:lightline = {
        \ 'colorscheme': s:lightline_colorscheme,
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
        \   'right': [ ['lineinfo', 'percent'], ['fileformat', 'fileencoding', 'filetype'] ]
        \ },
        \ 'inactive': {
        \   'left': [['filename']],
        \   'right': [['lineinfo', 'percent'], ['filetype']]
        \ },
        \ 'component': {
        \   'lineinfo': "\ue0a1 " . '%3l:%-2v',
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode',
        \ },
        \ 'separator': {'left': "\ue0b0 ", 'right': "\ue0b2 "},
        \ 'subseparator': {'left': "\ue0b1 ", 'right': "\ue0b3 "},
\ }

let s:palette = eval('g:lightline#colorscheme#' . s:lightline_colorscheme . '#palette')
let s:palette.tabline.tabsel = [['#444444', '#8ac6f2', '0', '39']]
let s:palette.tabline.right = [['#002b36', '#93a1a1', '234', '245'], ['#002b36', '#93a1a1', '234', '245']]
let s:palette.tabline.middle = [['#93a1a1', '#002b36', '245', '234']]
let s:palette.tabline.left = [['#002b36', '#93a1a1', '234', '245']]
unlet s:palette

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
    return &readonly ? "\uf023 " : ''
endfunction

function! LightlineFilename()
    if &ft ==? 'nerdtree'
        return ''
    else
        return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
            \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
            \  &ft == 'unite' ? unite#get_status_string() :
            \  &ft == 'vimshell' ? vimshell#get_status_string() :
            \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
            \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
    endif
endfunction

function! LightlineFugitive()
    if &ft ==? 'nerdtree'
        return ''
    elseif fugitive#head() != ''
        return "\ue725 " . fugitive#head()
    else
        return ''
    endif
endfunction

function! LightlineFileformat()
    if &ft ==? 'nerdtree'
        return ''
    else
        return winwidth(0) > 70 ? &fileformat : ''
    endif
endfunction

function! LightlineFiletype()
    if &ft ==? 'nerdtree'
        return ''
    else
        return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
    endif
endfunction

function! LightlineFileencoding()
    if &ft ==? 'nerdtree'
        return ''
    else
        return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
    endif
endfunction

function! LightlineMode()
  return winwidth(0) > 30 ? lightline#mode() : ''
endfunction

"reload lightline settings
command! LightlineReload call LightlineReload()
function! LightlineReload()
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction
"end lightline

" nnoremap <C-p> :bnext<CR>
" nnoremap <C-n> :bprevious<CR>

"vim-anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
nmap # <Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)
set statusline=%{anzu#search_status()}
"hide highlight and anzu-status
nmap <silent><esc><esc> :nohlsearch<CR><esc> <Plug>(anzu-clear-search-status)

"window
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sr <C-w>r
nnoremap sR <C-w>R
nnoremap s= <C-w>=
nnoremap sO <C-w>=
nnoremap sw <C-w>w
nnoremap so :<C-u>vertical res<CR><C-w>_
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sc :<C-u>only<CR>
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap s+ <C-w>+
nnoremap s- <C-w>-

" submode
let g:submode_always_show_submode = 1
let g:submode_timeoutlen = 2000

" submode : window_mode
call submode#enter_with('window_mode', 'n', '', 's>', '<C-w>>')
call submode#enter_with('window_mode', 'n', '', 's.', '<C-w>>')
call submode#enter_with('window_mode', 'n', '', 's<', '<C-w><')
call submode#enter_with('window_mode', 'n', '', 's,', '<C-w><')
call submode#enter_with('window_mode', 'n', '', 's+', '<C-w>+')
call submode#enter_with('window_mode', 'n', '', 's;', '<C-w>+')
call submode#enter_with('window_mode', 'n', '', 's-', '<C-w>-')
call submode#enter_with('window_mode', 'n', '', 's=', '<C-w>-')
call submode#enter_with('window_mode', 'n', '', 'sn', 'gt')
call submode#enter_with('window_mode', 'n', '', 'sp', 'gT')
call submode#enter_with('window_mode', 'n', '', 'sl', '<C-w>l')
call submode#enter_with('window_mode', 'n', '', 'sh', '<C-w>h')
call submode#enter_with('window_mode', 'n', '', 'sj', '<C-w>j')
call submode#enter_with('window_mode', 'n', '', 'sk', '<C-w>k')
call submode#enter_with('window_mode', 'n', '', 'sL', '<C-w>L')
call submode#enter_with('window_mode', 'n', '', 'sH', '<C-w>H')
call submode#enter_with('window_mode', 'n', '', 'sJ', '<C-w>J')
call submode#enter_with('window_mode', 'n', '', 'sK', '<C-w>K')
call submode#enter_with('window_mode', 'n', '', 'sr', '<C-w>r')
call submode#enter_with('window_mode', 'n', '', 'sR', '<C-w>R')
call submode#enter_with('window_mode', 'n', '', 'sO', '<C-w>=')
call submode#enter_with('window_mode', 'n', '', 'so', ':<C-u>vertical res<CR><C-w>_')
call submode#enter_with('window_mode', 'n', '', 'sw', '<C-w>w')
call submode#enter_with('window_mode', 'n', '', 'ss', ':<C-u>sp<CR>')
call submode#enter_with('window_mode', 'n', '', 'sv', ':<C-u>vs<CR>')
call submode#enter_with('window_mode', 'n', '', 'sc', ':<C-u>only<CR>')
call submode#enter_with('window_mode', 'n', '', 'sq', ':<C-u>q<CR>')
call submode#enter_with('window_mode', 'n', '', 'sQ', ':<C-u>bd<CR>')

call submode#map('window_mode', 'n', '', '>', '<C-w>>')
call submode#map('window_mode', 'n', '', '.', '<C-w>>')
call submode#map('window_mode', 'n', '', '<', '<C-w><')
call submode#map('window_mode', 'n', '', ',', '<C-w><')
call submode#map('window_mode', 'n', '', '+', '<C-w>+')
call submode#map('window_mode', 'n', '', ';', '<C-w>+')
call submode#map('window_mode', 'n', '', '-', '<C-w>-')
call submode#map('window_mode', 'n', '', '=', '<C-w>-')
call submode#map('window_mode', 'n', '', 'n', 'gt')
call submode#map('window_mode', 'n', '', 'p', 'gT')
call submode#map('window_mode', 'n', '', 'l', '<C-w>l')
call submode#map('window_mode', 'n', '', 'h', '<C-w>h')
call submode#map('window_mode', 'n', '', 'j', '<C-w>j')
call submode#map('window_mode', 'n', '', 'k', '<C-w>k')
call submode#map('window_mode', 'n', '', 'L', '<C-w>L')
call submode#map('window_mode', 'n', '', 'H', '<C-w>H')
call submode#map('window_mode', 'n', '', 'J', '<C-w>J')
call submode#map('window_mode', 'n', '', 'K', '<C-w>K')
call submode#map('window_mode', 'n', '', 'r', '<C-w>r')
call submode#map('window_mode', 'n', '', 'R', '<C-w>R')
call submode#map('window_mode', 'n', '', 'O', '<C-w>=')
call submode#map('window_mode', 'n', '', 'o', ':<C-u>vertical res<CR><C-w>_')
call submode#map('window_mode', 'n', '', 'w', '<C-w>w')
call submode#map('window_mode', 'n', '', 's', ':<C-u>sp<CR>')
call submode#map('window_mode', 'n', '', 'v', ':<C-u>vs<CR>')
call submode#map('window_mode', 'n', '', 'c', ':<C-u>only<CR>')
call submode#map('window_mode', 'n', '', 'q', ':<C-u>q<CR>')
call submode#map('window_mode', 'n', '', 'Q', ':<C-u>bd<CR>')

call submode#leave_with('window_mode', 'n', '', 'e')

" submode : undo/redo_mode
call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
call submode#map('undo/redo', 'n', '', '-', 'g-')
call submode#map('undo/redo', 'n', '', '+', 'g+')
call submode#leave_with('undo/redo', 'n', '', 'e')

"tab
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>

"buffer
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

"NERDTree
nnoremap <silent><leader>t :NERDTreeToggle<CR>
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowHidden=1
let g:NERDTreeChDirMode=2
let g:NERDTreeDirArrowExpandable = "\uf07b "
let g:NERDTreeDirArrowCollapsible = "\uf07c "

augroup nerdTreeGroup
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END

"vim-easymotion
let g:EasyMotion_smartcase = 1

"restart
let g:restart_sessionoptions = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

"vim-commentary
augroup vimCommentaryGroup
    autocmd!
    autocmd FileType matlab setlocal commentstring=%\ %s
augroup END

"ale
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_linters = {
\   'python': ['pylint'],
\   'matlab': ['mlint'],
\}
let g:ale_fixers = {
\   'python': ['autopep8'],
\}

"encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8

"ctags
set tags=./.tags;,.tags;
nnoremap tjn <C-]>
nnoremap tjN <C-t>
nnoremap <silent>tjl :vsp<CR> <C-w>l :exe("tjump ".expand('<cword>'))<CR>
nnoremap <silent>tjh :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <silent>tjj :sp<CR> <C-w>j :exe("tjump ".expand('<cword>'))<CR>
nnoremap <silent>tjk :sp<CR> :exe("tjump ".expand('<cword>'))<CR>

"markdown
augroup markdownGroup
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" Folding
augroup foldingGroup
    autocmd!
    autocmd ColorScheme * highlight Folded gui=bold guifg=LightGreen
augroup END

" restore vimsession
augroup RestoreVimSession
    autocmd!
    autocmd VimLeave * mks! ~/session.vim
augroup END

" show full path
command! Path echo expand("%:p")

"work only when delete plugins
function! s:deinClean()
    if len(dein#check_clean()) > 0
        echo "Processing..."
        call map(dein#check_clean(), "delete(v:val, 'rf')")
        call dein#recache_runtimepath()
        echo "DeinClean completed."
    else
        echo "There's no disabled plugins."
    endif
endfunction
command! DeinClean :call s:deinClean()

filetype plugin indent on
