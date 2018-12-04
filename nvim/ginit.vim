if has('win32') || has('win64')
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
endif

"color scheme
colorscheme molokai 
syntax on

"font
set guifont=MS_Gothic:h10.5:cDEFAULT
set guifontwide=MS_Gothic:h10.5:cDEFAULT
"set guifont=Fira_Mono_for_Powerline:h10:cANSI:qDRAFT
"set guifontwide=Fira_Mono_for_Powerline:h10:cANSI:qDRAFT

"hide bars
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
