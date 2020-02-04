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

    " lightline
    let g:lightline.component.lineinfo = "\ue0a1 " . '%3l:%-2v'
    let g:lightline.separator = {'left': "\ue0b0 ", 'right': "\ue0b2 "}
    let g:lightline.subseparator = {'left': "\ue0b1 ", 'right': "\ue0b3 "}
    let g:lightline.component_function.readonly = 'LightlineReadonly'
    let g:lightline.component_function.filename = 'LightlineFilename'
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
        if (&ft ==? 'nerdtree') || (winwidth(0) < 60)
            return ''
        elseif fugitive#head() != ''
            return "\ue725 " . fugitive#head()
        else
            return ''
        endif
    endfunction
    " lightline end

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
