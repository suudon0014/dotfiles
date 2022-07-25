" configs about lightline.vim
let s:lightline_colorscheme = 'sonokai'
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

" functions and commands
function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineGitbranch()
    let l:branch_name = gitbranch#name()
    if winwidth(0) < 60
        return ''
    elseif l:branch_name != ''
        return l:branch_name
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
    if winwidth(0) <= 40
        let l:mode = ''
    else
        let l:mode = lightline#mode()

        if mode()[0] ==# 'i'
            let l:skk_mode = skkeleton#mode()
            if l:skk_mode ==# ''
                let l:skk_label = 'A'
            elseif l:skk_mode ==# "hira"
                let l:skk_label = 'あ'
            elseif l:skk_mode ==# "kata"
                let l:skk_label = 'ア'
            elseif l:skk_mode ==# "hankata"
                let l:skk_label = 'ｱ'
            elseif l:skk_mode ==# "zenkaku"
                let l:skk_label = 'Ａ'
            elseif l:skk_mode ==# "abbrev"
                let l:skk_label = 'Abr'
            endif

            let l:mode = l:mode . '[' . l:skk_label . ']'
        endif
    endif

    return l:mode
endfunction

"reload lightline settings
command! LightlineReload call LightlineReload()
function! LightlineReload()
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction
