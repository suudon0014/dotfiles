filetype off

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
let s:dein_dir = expand('~\vimfiles\dein')
" dir of dein.vim
let s:dein_repo_dir = s:dein_dir . '\repos\github.com\Shougo\dein.vim'

"download dein.vim if there's no dein.vim
if &runtimepath !~# '\dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

"dein.vim settings
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    "create plugins list file using TOML format beforehand
    let g:rc_dir = expand('~\dotfiles')
    let s:toml = g:rc_dir . '\dein.toml'
    let s:lazy_toml = g:rc_dir . '\dein_lazy.toml'

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

"about search
set hlsearch
set ignorecase "search both upper/lower case
set smartcase "distinguish upper/lower if search word include upper

"completion of parentheses
imap [ []<left>
imap ( ()<left>
imap { {}<left>
imap < <><left>

"map jj to Esc
inoremap jj <Esc>
cnoremap jj <Esc>
inoremap ｊｊ <Esc>
cnoremap ｊｊ <Esc>

imap <C-j> <esc>

"key bindings of Space + another
let mapleader = "\<Space>"
noremap <Leader>v 0v$h
noremap <Leader>d 0v$hx
noremap <Leader>y 0v$hy

"space + h/l : move to beginning/end of the line
noremap <Leader>h ^
noremap <Leader>l $
vnoremap <Leader>l $h

"move to the bracket counterpart
noremap <Leader>b %

"tab
set tabstop=4 "set indent to four spaces
set autoindent
set expandtab
set shiftwidth=4

"etc.
set ruler
set number "display line number
set title "display file name
set showmatch "show corresponding bracket
set wildmenu
set showcmd
set clipboard=unnamed
set mouse=a
set iminsert=0
set imsearch=-1
set incsearch
set t_Co=256
set nowrap
set virtualedit+=block "enable to select place w/o character in <C-v> mode
set matchpairs+=<:>
let g:indentLine_char = '¦'


"lightline
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
\ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
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
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"end lightline

nnoremap <C-p> :bnext<CR>
nnoremap <C-n> :bprevious<CR>

"vim-anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
set statusline=%{anzu#search_status()}
"hide highlight and anzu-status
nmap <esc><esc> :nohlsearch<CR><esc> <Plug>(anzu-clear-search-status)

"restart
let g:restart_sessionoptions = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

"encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileencodings+=utf-8,euc-jp,iso-2022-jp,ucs-2le,ucs-2,cp932

"use only when delete plugins
"call map(dein#check_clean(), "delete(v:val, 'rf')")
"after above, execute :call dein#recache_runtimepath()

filetype plugin indent on
