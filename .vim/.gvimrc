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
        return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
            \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
            \  &ft == 'unite' ? unite#get_status_string() :
            \  &ft == 'vimshell' ? vimshell#get_status_string() :
            \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
            \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
    endfunction
    function! LightlineGitbranch()
        if gina#component#repo#branch() != ''
            return "\ue725 " . gina#component#repo#branch()
        else
            return ''
        endif
    endfunction
    LightlineReload
    " lightline end
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

"colorscheme
function! ModifyCobalt2()
    if g:colors_name == "cobalt2"
        set background=dark

        " Popup Colors
        highlight Pmenu ctermfg=255 ctermbg=55 guifg=#ffffff guibg=#3c2ba0
        highlight PmenuSel ctermfg=255 ctermbg=27 guifg=#ffffff guibg=#4174f4

        " CursorLine Colors
        set cursorline
        highlight CursorLine guibg=#28516f

        " Etc.
        highlight Visual ctermbg=244 guibg=#737373
        highlight LineNr ctermbg=12 guifg=#8ac6f2
        highlight Comment ctermfg=12 guifg=#34a4eb cterm=NONE gui=NONE
        highlight IncSearch ctermfg=0 ctermbg=226 guifg=#000000 guibg=#ffff00
        highlight Search ctermfg=0 ctermbg=45 guifg=#444444 guibg=#8ac6f2
        highlight VertSplit ctermfg=8 ctermbg=8 guifg=#777777 guibg=#777777
    endif
endfunction

augroup colorSchemeGroup
    autocmd!
    autocmd ColorScheme * :call ModifyCobalt2()
augroup END

colorscheme cobalt2
