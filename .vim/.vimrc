filetype off
filetype plugin indent off

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

if has('win64')
    let s:python_path = fnamemodify('~/.venv/neovim2/Scripts/python.exe', ':p')
    let s:python3_path = fnamemodify('~/.venv/neovim3/Scripts/python.exe', ':p')
elseif has('unix')
    let s:python_path = fnamemodify('~/.venv/neovim2/bin/python', ':p')
    let s:python3_path = fnamemodify('~/.venv/neovim3/bin/python', ':p')
endif

if executable(s:python_path)
  let g:python_host_prog = s:python_path
endif
if executable(s:python3_path)
  let g:python3_host_prog = s:python3_path
endif

let mapleader = "\<Space>"

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
    let g:rc_dir = expand('~/dotfiles/.vim')
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

"load separated setting files
set runtimepath+=~/dotfiles/.vim/
runtime! settings/*.vim

" colorscheme PaperColor
set termguicolors
colorscheme elly

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

"include dotfiles for ag searching via fzf
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'source': 'ag --hidden --ignore .git -g ""'}), <bang>0)

command! -bang -nargs=* Ag
    \ call fzf#vim#grep(
    \ 'ag --column --color --hidden --ignore .git '.shellescape(<q-args>), 0,
    \ <bang>0 ? fzf#vim#with_preview('up:60%')
    \         : fzf#vim#with_preview('right:50%', '?'),
    \ <bang>0)

nnoremap <silent> ,f :Files<CR>
nnoremap <silent> ,g :GFiles<CR>
nnoremap <silent> ,G :GFiles?<CR>
nnoremap <silent> ,b :Buffers<CR>
nnoremap <silent> ,l :BLines<CR>
nnoremap <silent> ,h :History<CR>
nnoremap <silent> ,c :History:<CR>
nnoremap <silent> ,a :Ag<Space>

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
    call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
    call nvim_win_set_option(win, 'winblend', 30)
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

"folding
set foldmethod=manual
set foldcolumn=1
augroup foldingGroup
    autocmd!
    autocmd BufWinLeave * mkview
    autocmd BufWinEnter * silent loadview
augroup END

"etc.
set background=light
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
set updatetime=150
set noequalalways
let g:indentLine_char = '¦'
noremap j gj
noremap k gk
noremap gj j
noremap gk k
tnoremap <S-Space> <Space>
imap <C-f> <C-x><C-o>

augroup etcSettingsGroup
    autocmd!
    autocmd BufRead,BufNewFile *.toml set filetype=toml
    autocmd QuickFixCmdPost *grep* cwindow
augroup END

"always search in very magic mode
nnoremap / /\v

"lightline
" let s:lightline_colorscheme = 'wombat'
let s:lightline_colorscheme = 'elly'
let g:lightline = {
        \ 'colorscheme': s:lightline_colorscheme,
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'filename' ] ],
        \   'right': [ ['lineinfo', 'percent'], ['fileformat', 'fileencoding', 'filetype'] ]
        \ },
        \ 'inactive': {
        \   'left': [['filename']],
        \   'right': [['lineinfo', 'percent'], ['filetype']]
        \ },
        \ 'component': {
        \   'lineinfo': '%3l:%-2v',
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'gitbranch': 'LightlineGitbranch',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode',
        \ },
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

function! LightlineGitbranch()
    if winwidth(0) < 60
        return ''
    elseif gina#component#repo#branch() != ''
        return gina#component#repo#branch()
    else
        return ''
    endif
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 40 ? lightline#mode() : ''
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

cnoremap <C-p> <Up>

"vim-anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
nmap # <Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)
set statusline=%{anzu#search_status()}
"hide highlight and anzu-status
nmap <silent><esc><esc> :nohlsearch<CR><esc> <Plug>(anzu-clear-search-status)

"buffer
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

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
set fileencodings=utf-8,sjis
set termencoding=utf-8
set fileformats=unix,dos

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
syntax on
