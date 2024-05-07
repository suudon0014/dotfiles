" configs about ddu.vim

" mappings
nnoremap <silent> ,ff :call <SID>DduStart('file_rec', v:true, v:false, v:true, [['[FILE]', 'Blue']])<CR>
nnoremap <silent> ,l :call <SID>DduStart('line', v:true, v:false, v:true, [['[LINE]', 'Blue']])<CR>
nnoremap <silent> ,b :call <SID>DduStart('buffer', v:true, v:false, v:true, [['[BUFFER]', 'Blue']])<CR>
nnoremap ,rw :DduGrep<Space>
nnoremap <silent> ,rl :call <SID>DduGrep('', v:true)<CR>
nnoremap <silent> ,ra :call <SID>DduGrepCWord()<CR>
nnoremap <silent> ,c :call <SID>DduStart('command_history', v:false, v:false, v:true, [['[CMD_HIST]', 'Blue']])<CR>
nnoremap <silent> ,C :call <SID>DduStart('colorscheme', v:false, v:false, v:true, [['[COLORSCHEME]', 'Blue']])<CR>
nnoremap <silent> ,H :call <SID>DduStart('help', v:true, v:false, v:true, [['[HELP]', 'Blue']])<CR>
nnoremap <silent> ,d :call <SID>DduStart('dirmark_custom', v:false, v:true, v:false, [['[DIRMARK]', 'Blue']])<CR>
nnoremap <silent> ,m :call <SID>DduStart('marks', v:true, v:false, v:true, [['[MARKS]', 'Blue']])<CR>
nnoremap <silent> ,u :call <SID>DduStart('dein_update', v:false, v:false, v:true, [['[DEIN]', 'Blue']])<CR>
nnoremap <silent> ,t :call <SID>DduFilerSideBarStart()<CR>
nnoremap <silent> ,fs :call <SID>DduFilerSingleStart()<CR>
nnoremap <silent> ,fd :call <SID>DduFilerDualStart()<CR>
nnoremap <silent> ,gd :call <SID>DduStart('git_diff', v:true, v:false, v:true, [['[GIT_DIFF]', 'Blue']])<CR>
nnoremap <silent> ,gr :call <SID>DduStart('git_ref', v:true, v:false, v:true, [['[GIT_SHOW_REF]', 'Blue']])<CR>
nnoremap <silent> ,gs :call <SID>DduStart('git_status', v:true, v:false, v:true, [['[GIT_STATUS]', 'Blue']])<CR>
nnoremap <silent> ,w :call <SID>DduStart('window_custom', v:true, v:true, v:true, [['[WINDOW]', 'Blue']])<CR>
nnoremap <silent> ,al :call <SID>DduStart('arglist', v:true, v:false, v:true, [['[ARG_LIST]', 'Blue']])<CR>

nnoremap <silent> ,on :call <SID>DduStart('obsidian_note', v:true, v:false, v:true, [['[OBS]', 'Blue']])<CR>

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

function! s:DduStart(source, preview_enable, custom_enable, start_filter, floating_title) abort
    if a:preview_enable
        let s:ui_params = s:ddu_win_and_preview_pos
        " let s:ui_params['autoAction'] = {'name': 'preview'}
    else
        let s:ui_params = s:ddu_win_pos
    endif

    let s:ui_params['floatingTitle'] = a:floating_title

    if a:custom_enable
        call ddu#start({'name': a:source,
            \ 'uiParams': {'ff': s:ui_params},
        \ })
    else
        call ddu#start({'sources': [{'name': a:source}],
            \ 'uiParams': {'ff': s:ui_params},
        \ })
    endif
    if a:start_filter
        autocmd User Ddu:uiReady ++once
            \ : if &l:filetype ==# 'ddu-ff'
            \ |     call ddu#ui#do_action('openFilterWindow')
            \ | endif
    endif
endfunction

command! -nargs=* DduGrep :call <SID>DduGrep(<f-args>)
function! s:DduGrep(...) abort
    let volatile = v:false
    let word = ''
    if a:0 == 0
        let volatile = v:true
    elseif a:0 == 1
        let word = a:1
    elseif a:0 == 2
        let word = a:1
        let volatile = a:2
    endif

    let s:ui_params = s:ddu_win_and_preview_pos
    let s:ui_params['floatingTitle'] = [['[GREP]', 'Blue']]
    " let s:ui_params['autoAction'] = {'name': 'preview'}
    call ddu#start({
        \ 'uiParams': {'ff': s:ui_params},
        \ 'sources': [{
        \   'name': 'rg',
        \   'params': {'input': word},
        \   'options': {'volatile': volatile},
        \ }]
    \ })
endfunction

function! s:DduGrepCWord() abort
    call <SID>DduGrep(expand('<cword>'))
endfunction

function! s:DduFilerSingleStart() abort
    let s:ui_params = s:ddu_win_and_preview_pos
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
                \ 'converters': ['converter_file_info'],
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
            \ 'winHeight': 20,
            \ 'winWidth': &columns / 2,
            \ 'previewHeight': 20,
            \ 'previewWidth': &columns / 2,
            \ 'previewFloating': v:true,
            \ 'previewFloatingBorder': 'single',
            \ 'previewSplit': 'vertical',
            \ 'filterSplitDirection': 'floating',
            \ 'filterFloatingPosition': 'bottom',
            \ 'reversed': v:false,
            \ 'prompt': '> ',
        \ },
        \ 'filer': {
            \ 'split': 'floating',
            \ 'sort': 'filename',
            \ 'sortTreesFirst': v:true,
            \ 'floatingBorder': 'single',
            \ 'previewHeight': 20,
            \ 'previewWidth': &columns / 2,
            \ 'previewFloating': v:true,
            \ 'previewFloatingBorder': 'single',
            \ 'previewSplit': 'vertical',
            \ 'previewFloatingZindex': 100,
        \ },
    \ },
    \ 'sourceParams': #{
        \ file_rec: #{
            \ ignoredDirectories: ['.git', '.cache', '.clangd', '.vs', '.obsidian', '.obsidian_win', '.obsidian_android', '.trash'],
        \ },
        \ rg: #{
            \ args: ['--column', '--no-heading', '--no-ignore', '--glob', '!.git/', '--hidden', '--color', 'never', '--smart-case', '--json'],
            \ highlights: #{
                \ path: 'Identifier',
                \ lineNr: 'Comment',
                \ word: 'Constant',
            \ },
        \ },
        \ help: #{
            \ helpLang: 'ja,en',
        \ },
        \ dein_update: #{
            \ maxProcess: 8,
        \ },
        \ obsidian_note: #{
            \ vaults: [#{
                \ path: expand('~/OneDrive/obsidian'),
                \ name: 'obsidian_vault',
            \ }]
        \ },
    \ },
    \ 'sourceOptions': #{
        \ _: #{
            \ matchers: ['matcher_fzf'],
            \ sorters: ['sorter_fzf'],
        \ },
        \ dirmark: #{
            \ defaultAction: 'cd',
        \ },
        \ dein_update: #{
            \ matchers: ['matcher_dein_update', 'matcher_fzf'],
        \ },
        \ file_rec: #{
            \ converters: [{'name': 'converter_hl_dir'}],
        \ },
        \ obsidian_note: #{
            \ matchers: [
                \ 'converter_obsidian_rel_path',
                \ 'converter_obsidian_title',
                \ 'converter_display_word',
                \ 'matcher_fzf',
            \ ],
            \ converters: ['converter_obsidian_backlink']
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
        \ 'dein_update': {
            \ 'defaultAction': 'viewDiff',
        \ },
        \ 'window': {
            \ 'defaultAction': 'open',
        \ },
        \ 'git_tag': {
            \ 'defaultAction': 'switch',
        \ },
        \ 'git_branch': {
            \ 'defaultAction': 'switch',
        \ },
        \ 'lsp': {
            \ 'defaultAction': 'open',
        \ },
        \ 'lsp_codeAction': {
            \ 'defaultAction': 'apply',
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
        \ 'echo': {
            \ 'quit': v:false,
        \ },
        \ 'echoDiff': {
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
    \ 'sources': [{'name': 'dirmark'}],
    \ 'actionOptions': {
        \ 'cd': {
            \ 'quit': v:true,
        \ },
    \ },
\ })

call ddu#custom#patch_local('window_custom', {
    \ 'uiParams': {
        \ 'ff': {
            \ 'autoAction': {'name': 'preview'},
    \ }},
    \ 'sources': [{
        \ 'name': 'window',
        \ 'params': {'ignoreBufNames': ["ddu-ff-filter-window_custom", "ddu-ff-window_custom"]},
    \ }],
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
