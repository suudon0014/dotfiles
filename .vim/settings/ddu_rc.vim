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
nnoremap <silent> ,t :call ddu#start({'name': 'filer_side_bar'})<CR>
nnoremap <silent> ,fs :call <SID>DduFilerSingleStart()<CR>
nnoremap <silent> ,fd :call <SID>DduFilerDualStart()<CR>

autocmd FileType ddu-ff call s:ddu_ff_mappings()
function! s:ddu_ff_mappings() abort
    nnoremap <buffer><silent> <CR> <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
    nnoremap <buffer><silent> s <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'open', 'params': {'command': 'split'}})<CR>
    nnoremap <buffer><silent> v <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
    nnoremap <buffer><silent> x <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
    nnoremap <buffer><silent> a <Cmd>call ddu#ui#ff#do_action('toggleAllItems')<CR>
    nnoremap <buffer><silent> r <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'rename'})<CR>
    nnoremap <buffer><silent> f <Cmd>call ddu#ui#ff#do_action('refreshItems')<CR>
    nnoremap <buffer><silent> c <Cmd>call ddu#ui#ff#do_action('chooseAction')<CR>
    nnoremap <buffer><silent> d <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'delete'})<CR>
    nnoremap <buffer><silent> e <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'edit'})<CR>
    nnoremap <buffer><silent> t <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'tabopen'})<CR>
    nnoremap <buffer><silent> p <Cmd>call ddu#ui#ff#do_action('preview')<CR>
    nnoremap <buffer><silent> i <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
    nnoremap <buffer><silent> <leader>y <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'yank'})<CR>
    nnoremap <buffer><silent> <leader>l <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'loclist'})<CR>
    nnoremap <buffer><silent> <leader>q <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'quickfix'})<CR>
    nnoremap <buffer><silent> q <Cmd>call ddu#ui#ff#do_action('quit')<CR>
    nnoremap <buffer> <Esc><Esc> <Nop>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_ff_filter_mappings()
function! s:ddu_ff_filter_mappings() abort
    AutoCloseOff
    inoremap <buffer><silent> <CR> <Esc><Cmd>close<CR>
    nnoremap <buffer><silent> <CR> <Cmd>close<CR>
    nnoremap <buffer><silent> q <Cmd>close<CR>
endfunction

autocmd FileType ddu-filer call s:ddu_filer_mappings()
function! s:ddu_filer_mappings() abort
    nnoremap <buffer><silent><expr> l ddu#ui#filer#is_directory() ?
        \ "<Cmd>call ddu#ui#filer#do_action('expandItem')<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'params': {'command': 'drop'}})<CR>"
    nnoremap <buffer><silent><expr> h ddu#ui#filer#is_directory() ? "<Cmd>call ddu#ui#filer#do_action('collapseItem')<CR>" : ""
    nnoremap <buffer><silent> <S-l> <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'cd'})<CR><Cmd>call ddu#ui#filer#do_action('refreshItems')<CR>
    nnoremap <buffer><silent> <S-h> <Cmd>cd..<CR><Cmd>call ddu#ui#filer#do_action('refreshItems')<CR>
    nnoremap <buffer><silent> x <Cmd>call ddu#ui#filer#do_action('toggleSelectItem')<CR>
    nnoremap <buffer><silent><expr> <CR> ddu#ui#filer#is_directory() ?
        \ "<Cmd>call ddu#ui#filer#do_action('expandItem', {'mode': 'toggle'})<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'params': {'command': 'drop'}})<CR>"
    nnoremap <buffer><silent> r <Cmd>call ddu#ui#filer#do_action('refreshItems')<CR>
    nnoremap <buffer><silent><expr> o ddu#ui#filer#is_directory() ? "" : "<Cmd>call ddu#ui#filer#do_action('itemAction')<CR>"
    nnoremap <buffer><silent><expr> s ddu#ui#filer#is_directory() ? "" : "<Cmd>call ddu#ui#filer#do_action('itemAction', {'params': {'command': 'split'}})<CR>"
    nnoremap <buffer><silent><expr> v ddu#ui#filer#is_directory() ? "" : "<Cmd>call ddu#ui#filer#do_action('itemAction', {'params': {'command': 'vsplit'}})<CR>"
    nnoremap <buffer><silent> <leader>b <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'dirmark'})<CR>
    nnoremap <buffer><silent> <leader>c <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'copy'})<CR>
    nnoremap <buffer><silent> <leader>d <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'delete'})<CR>
    nnoremap <buffer><silent> <leader>k <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newDirectory'})<CR>
    nnoremap <buffer><silent> <leader>l <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'loclist'})<CR>
    nnoremap <buffer><silent> <leader>m <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'move'})<CR>
    nnoremap <buffer><silent> <leader>n <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newFile'})<CR>
    nnoremap <buffer><silent> <leader>p <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'paste'})<CR>
    nnoremap <buffer><silent> <leader>q <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'quickfix'})<CR>
    nnoremap <buffer><silent> <leader>r <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'rename'})<CR>
    nnoremap <buffer><silent> <leader>y <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'yank'})<CR>
    nnoremap <buffer><silent> q <Cmd>close<CR>
    nnoremap <buffer> <Esc><Esc> <Nop>
endfunction


" functions and commands
function! s:get_ddu_win_and_preview_pos() abort
    return {
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

function! s:get_ddu_win_pos() abort
    return {
        \ 'winWidth': float2nr(&columns * 0.9),
        \ 'winCol': float2nr(&columns * 0.05),
        \ 'winHeight': float2nr(&lines * 0.6),
        \ 'winRow': float2nr(&lines * 0.2),
    \ }
endfunction

function! s:DduStart(source, preview_enable, custom_enable) abort
    if a:preview_enable
        let s:win_pos = <SID>get_ddu_win_and_preview_pos()
        let s:win_pos['autoAction'] = {'name': 'preview'}
    else
        let s:win_pos = <SID>get_ddu_win_pos()
    endif

    if a:custom_enable
        call ddu#start({'name': a:source,
            \ 'uiParams': {'ff': s:win_pos},
        \ })
    else
        call ddu#start({'sources': [{'name': a:source}],
            \ 'uiParams': {'ff': s:win_pos},
        \ })
    endif
endfunction

command! -nargs=1 DduGrep :call <SID>DduGrep(<f-args>)
function! s:DduGrep(word) abort
    let s:win_pos = <SID>get_ddu_win_and_preview_pos()
    let s:win_pos['autoAction'] = {'name': 'preview'}
    call ddu#start({
        \ 'uiParams': {'ff': s:win_pos},
        \ 'sources': [{'name': 'rg', 'params': {'input': a:word}}]
    \ })
endfunction

function! s:DduGrepCWord() abort
    call <SID>DduGrep(expand('<cword>'))
endfunction

function! s:DduFilerSingleStart() abort
    let s:ui_params = <SID>get_ddu_win_pos()
    call ddu#start({
        \ 'name': 'filer_single',
        \ 'uiParams': {
            \ 'filer': s:ui_params,
    \ }})
endfunction

function! s:DduFilerDualStart() abort
    let s:win_and_preview_pos = <SID>get_ddu_win_and_preview_pos()

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
    \ }})
    call ddu#start({
        \ 'name': 'filer_dual_left',
        \ 'uiParams': {
            \ 'filer': s:ui_params_left,
    \ }})
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
    \ 'sources': [{'name': 'file',}],
    \ 'sourceOptions': {
        \ 'file': {'columns': ['icon_filename']}
    \ },
\ })

call ddu#custom#patch_local('filer_dual_left', {
    \ 'ui': 'filer',
    \ 'sources': [{'name': 'file',}],
    \ 'sourceOptions': {
        \ 'file': {'columns': ['icon_filename']}
    \ },
\ })

call ddu#custom#patch_local('filer_dual_right', {
    \ 'ui': 'filer',
    \ 'sources': [{'name': 'file',}],
    \ 'sourceOptions': {
        \ 'file': {'columns': ['icon_filename']}
    \ },
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
    \ 'sources': [{'name': 'file',}],
    \ 'sourceOptions': {
        \ 'file': {'columns': ['icon_filename']}
    \ },
\ })

