" configs about ddu.vim

" mappings
nnoremap <silent> ,ff :call <SID>DduStart('file_rec', v:true, v:false)<CR>
nnoremap <silent> ,l :call <SID>DduStart('line', v:true, v:false)<CR>
nnoremap <silent> ,b :call <SID>DduStart('buffer', v:true, v:false)<CR>
nnoremap ,r :DduGrep<Space>
nnoremap <silent> ,a :call <SID>DduGrepCWord()<CR>
nnoremap <silent> ,c :call <SID>DduStart('command_history', v:false, v:false)<CR>
nnoremap <silent> ,C :call <SID>DduStart('colorscheme', v:false, v:false)<CR>
nnoremap <silent> ,H :call <SID>DduStart('help', v:true, v:false)<CR>
nnoremap <silent> ,d :call <SID>DduStart('dirmark_custom', v:false, v:true)<CR>
nnoremap <silent> ,m :call <SID>DduStart('marks', v:true, v:false)<CR>
nnoremap <silent> ,t :call <SID>DduFilerSideBarStart()<CR>
nnoremap <silent> ,fs :call <SID>DduFilerSingleStart()<CR>
nnoremap <silent> ,fd :call <SID>DduFilerDualStart()<CR>

" functions and commands
function! s:set_ddu_win_pos() abort
    let s:ddu_win_pos = {
        \ 'winWidth': float2nr(&columns * 0.9),
        \ 'winCol': float2nr(&columns * 0.05),
        \ 'winHeight': float2nr(&lines * 0.6),
        \ 'winRow': float2nr(&lines * 0.2),
    \ }
endfunction

function! s:set_ddu_win_and_preview_pos() abort
    let s:ddu_win_and_preview_pos = {
        \ 'winWidth': float2nr(&columns * 0.45),
        \ 'winCol': float2nr(&columns * 0.05),
        \ 'winHeight': float2nr(&lines * 0.6),
        \ 'winRow': float2nr(&lines * 0.2),
        \ 'previewWidth': float2nr(&columns * 0.45),
        \ 'previewCol': float2nr(&columns * 0.5),
        \ 'previewHeight': float2nr(&lines * 0.6),
        \ 'previewRow': float2nr(&lines * 0.2),
    \ }
endfunction

augroup AutoResizeDduWinPos
    autocmd!
    autocmd VimEnter,VimResized * call s:set_ddu_win_pos()
    autocmd VimEnter,VimResized * call s:set_ddu_win_and_preview_pos()
augroup END

function! s:DduStart(source, preview_enable, custom_enable) abort
    if a:preview_enable
        let s:ui_params = s:ddu_win_and_preview_pos
        let s:ui_params['autoAction'] = {'name': 'preview'}
    else
        let s:ui_params = s:ddu_win_pos
    endif

    if a:custom_enable
        call ddu#start({'name': a:source,
            \ 'uiParams': {'ff': s:ui_params},
        \ })
    else
        call ddu#start({'sources': [{'name': a:source}],
            \ 'uiParams': {'ff': s:ui_params},
        \ })
    endif
endfunction

command! -nargs=1 DduGrep :call <SID>DduGrep(<f-args>)
function! s:DduGrep(word) abort
    let s:ui_params = s:ddu_win_and_preview_pos
    let s:ui_params['autoAction'] = {'name': 'preview'}
    call ddu#start({
        \ 'uiParams': {'ff': s:ui_params},
        \ 'sources': [{'name': 'rg', 'params': {'input': a:word}}]
    \ })
endfunction

function! s:DduGrepCWord() abort
    call <SID>DduGrep(expand('<cword>'))
endfunction

function! s:DduFilerSingleStart() abort
    let s:ui_params = s:ddu_win_pos
    call ddu#start({
        \ 'name': 'filer_single',
        \ 'uiParams': {
            \ 'filer': s:ui_params,
        \ },
        \ 'sources': [{
            \ 'name': 'file',
            \ 'options': {
                \ 'columns': ['icon_filename'],
                \ 'path': getcwd(),
            \ },
        \ }],
    \ })
endfunction

function! s:DduFilerDualStart() abort
    let s:win_and_preview_pos = s:ddu_win_and_preview_pos

    let s:ui_params_left = {
        \ 'winWidth': s:win_and_preview_pos['winWidth'],
        \ 'winCol': s:win_and_preview_pos['winCol'],
        \ 'winHeight': s:win_and_preview_pos['winHeight'],
        \ 'winRow': s:win_and_preview_pos['winRow'],
    \ }
    let s:ui_params_right = {
        \ 'winWidth': s:win_and_preview_pos['previewWidth'],
        \ 'winCol': s:win_and_preview_pos['previewCol'],
        \ 'winHeight': s:win_and_preview_pos['previewHeight'],
        \ 'winRow': s:win_and_preview_pos['previewRow'],
    \ }

    call ddu#start({
        \ 'name': 'filer_dual_right',
        \ 'uiParams': {
            \ 'filer': s:ui_params_right,
        \ },
        \ 'sources': [{
            \ 'name': 'file',
            \ 'options': {
                \ 'columns': ['icon_filename'],
                \ 'path': getcwd(),
            \ },
        \ }],
    \ })
    call ddu#start({
        \ 'name': 'filer_dual_left',
        \ 'uiParams': {
            \ 'filer': s:ui_params_left,
        \ },
        \ 'sources': [{
            \ 'name': 'file',
            \ 'options': {
                \ 'columns': ['icon_filename'],
                \ 'path': getcwd(),
            \ },
        \ }],
    \ })
endfunction

function! s:DduFilerSideBarStart() abort
    call ddu#start({
        \ 'name': 'filer_side_bar',
        \ 'sources': [{
            \ 'name': 'file',
            \ 'options': {
                \ 'columns': ['icon_filename'],
                \ 'path': getcwd(),
            \ },
        \ }],
    \ })
endfunction

" patches
call ddu#custom#patch_global({
    \ 'ui': 'ff',
    \ 'uiParams': {
        \ 'ff': {
            \ 'split': 'floating',
            \ 'floatingBorder': 'single',
            \ 'startFilter': v:true,
            \ 'winHeight': 20,
            \ 'winWidth': &columns / 2,
            \ 'previewHeight': 20,
            \ 'previewWidth': &columns / 2,
            \ 'previewFloating': v:true,
            \ 'previewFloatingBorder': 'single',
            \ 'previewVertical': v:true,
            \ 'filterSplitDirection': 'floating',
            \ 'reversed': v:false,
            \ 'prompt': '> ',
        \ },
        \ 'filer': {
            \ 'split': 'floating',
        \ },
    \ },
    \ 'sourceParams': {
        \ 'file_rec': {
            \ 'ignoredDirectories': ['.git', '.cache', '.clangd', '.vs'],
        \ },
        \ 'rg': {
            \ 'args': ['--column', '--no-heading', '--no-ignore', '--glob', '!.git/', '--hidden', '--color', 'never', '--smart-case', '--json'],
            \ 'highlights': {
                \ 'path': 'Identifier',
                \ 'lineNr': 'Comment',
                \ 'word': 'Constant',
            \ },
        \ },
        \ 'help': {
            \ 'helpLang': 'ja,en',
        \ },
    \ },
    \ 'sourceOptions': {
        \ '_': {
            \ 'matchers': ['matcher_fzf'],
        \ },
        \ 'dirmark': {
            \ 'defaultAction': 'cd',
        \ },
    \ },
    \ 'kindOptions': {
        \ 'file': {
            \ 'defaultAction': 'open',
        \ },
        \ 'action': {
            \ 'defaultAction': 'do',
        \ },
        \ 'command_history': {
            \ 'defaultAction': 'execute',
        \ },
        \ 'colorscheme': {
            \ 'defaultAction': 'set',
        \ },
        \ 'help': {
            \ 'defaultAction': 'vsplit',
        \ },
    \ },
    \ 'actionOptions': {
        \ 'narrow': {
            \ 'quit': v:false,
        \ },
        \ 'cd': {
            \ 'quit': v:false,
        \ },
        \ 'dirmark': {
            \ 'quit': v:false,
        \ },
    \ },
    \ 'filterParams': {
        \ 'matcher_fzf': {
            \ 'highlightMatched': 'Search',
        \ },
    \ },
    \ 'columnParams': {
        \ 'filename': {
            \ 'collapsedIcon': "\ue5ff",
            \ 'expandedIcon': "\ue5fe",
        \ },
        \ 'icon_filename': {
            \ 'defaultIcon': {
                \ 'icon': "\uf016",
            \ },
        \ },
    \ },
\ })

call ddu#custom#patch_local('dirmark_custom', {
    \ 'uiParams': {
        \ 'ff': {
            \ 'startFilter': v:false,
        \ },
    \ },
    \ 'sources': [{'name': 'dirmark'}],
    \ 'actionOptions': {
        \ 'cd': {
            \ 'quit': v:true,
        \ },
    \ },
\ })

call ddu#custom#patch_local('filer_single', {
    \ 'ui': 'filer',
\ })

call ddu#custom#patch_local('filer_dual_left', {
    \ 'ui': 'filer',
\ })

call ddu#custom#patch_local('filer_dual_right', {
    \ 'ui': 'filer',
\ })

call ddu#custom#patch_local('filer_side_bar', {
    \ 'ui': 'filer',
    \ 'uiParams': {
        \ 'filer': {
            \ 'split': 'vertical',
            \ 'splitDirection': 'topleft',
            \ 'winWidth': 30,
    \ }},
    \ 'uiOptions': {
        \ 'filer': {
            \ 'toggle': v:true,
    \ }},
\ })
