if has('win32') || has('win64')
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
endif

" deopleteのポップアップ色の変更
autocmd ColorScheme * highlight Pmenu guifg=#ffffff guibg=#3c2ba0
autocmd ColorScheme * highlight PmenuSel guifg=#ffffff guibg=#4174f4

"color scheme
autocmd ColorScheme * highlight Visual guibg=#646464
autocmd ColorScheme * highlight LineNr guifg=#b0c4de
autocmd ColorScheme * highlight IncSearch guifg=#000000 guibg=#ffff00
autocmd ColorScheme * highlight Search guifg=#000000 guibg=#66cdaa
colorscheme cobalt2
syntax on

"font
set guifont=Ricty_Diminished:h11
set guifontwide=Ricty_Diminished:h11
" set guifont=MS_Gothic:h10.5:cDEFAULT
" set guifontwide=MS_Gothic:h10.5:cDEFAULT

"hide bars
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
