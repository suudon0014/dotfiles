if has('win32') || has('win64')
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
endif

"color scheme
autocmd ColorScheme * highlight Visual guibg=#646464
autocmd ColorScheme * highlight LineNr guifg=#b0c4de
colorscheme molokai 
syntax on

"font
Guifont! Ricty Diminished:h11

"hide bars
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
