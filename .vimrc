source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"dein.vim
"if &compatible
"	set nocompatible
"endif
"set runtimepath+=E:/vim/bundle/dein.vim
"call dein#begin(expand('E:\vim\bundle'))
"call dein#add('lightline.vim')
"call dein#end()

"set folders for plugin
"set runtimepath+=C:/Users/sudo/vimfiles/plugin

set guifont=ＭＳ_ゴシック:h10:cSHIFTJIS:qDRAFT

"set backup folders
set undodir=C:/vimtmp/undo
set backupdir=C:/vimtmp/bk
set directory=C:/vimtmp/swap

"about search
set hlsearch
set ignorecase "search both upper/lower case
set smartcase "distinguish upper/lower if search word include upper
"hide highlight
nmap <esc><esc> :nohlsearch<CR><esc> 

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

"color scheme
"colorscheme molokai 

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
syntax on "show code in color
set nowrap
set virtualedit+=block "enable to select place w/o character in <C-v> mode
set matchpairs+=<:>,＜:＞,（:）,「:」,『:』,［:］,【:】
