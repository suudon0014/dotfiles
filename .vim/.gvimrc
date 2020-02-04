if has('win32') || has('win64')
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
endif

if has('nvim')
    Guifont! Cica:h11
    GuiPopupmenu 0
    GuiTabline 0
    set pumblend=30

    let g:NERDTreeDirArrowExpandable = "\uf07b "
    let g:NERDTreeDirArrowCollapsible = "\uf07c "
else
    set guifont=Cica:h11
    set guifontwide=Cica:h11
endif

"hide bars
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
