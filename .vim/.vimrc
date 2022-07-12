filetype off
filetype plugin indent off

if has('kaoriya')
    let g:no_vimrc_example=0
    let g:vimrc_local_finish=1
    let g:gvimrc_local_finish=1

	"$VIM/plugins/kaoriya/autodate.vim
	let plugin_autodate_disable  = 1
	"$VIM/plugins/kaoriya/cmdex.vim
	let plugin_cmdex_disable     = 1
	"$VIM/plugins/kaoriya/dicwin.vim
	let plugin_dicwin_disable    = 1
	"$VIMRUNTIME/plugin/format.vim
	let plugin_format_disable    = 1
	"$VIM/plugins/kaoriya/hz_ja.vim
	let plugin_hz_ja_disable     = 1
	"$VIM/plugins/kaoriya/scrnmode.vim
	let plugin_scrnmode_disable  = 1
	"$VIM/plugins/kaoriya/verifyenc.vim
	let plugin_verifyenc_disable = 1
endif

if has('win64')
    let s:python_path = fnamemodify('~/.venv/neovim2/Scripts/python.exe', ':p')
    let s:python3_path = fnamemodify('~/.venv/neovim3/Scripts/python.exe', ':p')
elseif has('unix')
    let s:python_path = fnamemodify('~/.venv/neovim2/bin/python', ':p')
    let s:python3_path = fnamemodify('~/.venv/neovim3/bin/python', ':p')
endif

if executable(s:python_path)
  let g:python_host_prog = s:python_path
endif
if executable(s:python3_path)
  let g:python3_host_prog = s:python3_path
endif

let mapleader = "\<Space>"

"Plugin managed by dein.vim
"installing directory
" let s:dein_dir = expand('~/vimfiles/dein')
let s:dein_dir = expand('~/.cache/dein')
" dir of dein.vim
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

"download dein.vim if there's no dein.vim
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

"dein.vim settings
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    "create plugins list file using TOML format beforehand
    let s:rc_dir = expand('~/dotfiles/.vim')
    let s:toml = s:rc_dir . '/dein.toml'
    let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'

    "read and cache the toml files
    call dein#load_toml(s:toml, {'lazy':0})
    call dein#load_toml(s:lazy_toml, {'lazy':1})

    "end the setting
    call dein#end()
    call dein#save_state()
endif

"install if there are plugins not installed
function! s:deinInstall()
    if dein#check_install()
        call dein#install()
    else
        echo "All plugins have already installed."
    endif
endfunction
command! DeinInstall :call s:deinInstall()
DeinInstall

"work only when delete plugins
function! s:deinClean()
    if len(dein#check_clean()) > 0
        echo "Processing..."
        call map(dein#check_clean(), "delete(v:val, 'rf')")
        call dein#recache_runtimepath()
        echo "DeinClean completed."
    else
        echo "There's no disabled plugins."
    endif
endfunction
command! DeinClean :call s:deinClean()

"update plugins using Github GraphQL API
let g:dein#install_github_api_token = $GITHUB_API_TOKEN
function! s:deinUpdate()
    if !empty(g:dein#install_github_api_token)
        call dein#check_update(v:true)
        echo "DeinUpdate completed."
    else
        echo "[Error] Set $GITHUB_API_TOKEN and restart vim for DeinUpdate to work."
    endif
endfunction
command! DeinUpdate :call s:deinUpdate()

autocmd VimEnter * call dein#call_hook('post_source')

"set backup folders
set undodir=$HOME/vimtmp/undo
set backupdir=$HOME/vimtmp/bk
set directory=$HOME/vimtmp/swap
set noswapfile

"load separated setting files
set runtimepath+=~/dotfiles/.vim/
runtime! settings/*.vim

"colorscheme
set background=dark
set cursorline
highlight link LspErrorHighlight NeomakeErrorMsg
highlight link LspWarningHighlight NeomakeWarningMsg
set termguicolors
colorscheme sonokai

" ddc.vim
call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('autoCompleteEvents',
    \ ['InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineEnter', 'CmdlineChanged']
\)
call ddc#custom#patch_global('sources', [
    \ 'nvim-lsp',
    \ 'vsnip',
    \ 'around',
    \ 'file',
    \ 'skkeleton',
    \ 'cmdline-history',
\ ])
call ddc#custom#patch_global('sourceOptions', {
    \ '_': {
    \     'matchers': ['matcher_fuzzy'],
    \     'sorters': ['sorter_fuzzy'],
    \     'converters': ['converter_fuzzy'],
    \     'ignoreCase' : v:true,
    \     'minAutoCompleteLength': 1,
    \ },
    \ 'nvim-lsp': {
    \     'mark': '[lsp]',
    \     'forceCompletionPattern': '\.|:|->|"\w*/*',
    \ },
    \ 'vsnip': {'mark': '[vsnip]', 'dup': v:true,},
    \ 'around': {'mark': '[around]'},
    \ 'file': {
    \     'mark': '[file]',
    \     'isVolatile': v:true,
    \     'forceCompletionPattern': '\S/\S*'
    \ },
    \ 'skkeleton': {
    \   'mark': '[skk]',
    \   'matchers': ['skkeleton'],
    \   'sorters': []
    \ },
    \ 'cmdline-history': {
    \   'mark': '[cmdhist]',
    \ },
\ })

nnoremap : <Cmd>call CommandlinePre()<CR>:
function! CommandlinePre() abort
    cnoremap <Tab> <Cmd>call pum#map#insert_relative(+1)<CR>
    cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
    cnoremap <C-n> <Cmd>call pum#map#insert_relative(+1)<CR>
    cnoremap <C-p> <Cmd>call pum#map#insert_relative(-1)<CR>
    cnoremap <C-y> <Cmd>call pum#map#confirm()<CR>
    cnoremap <C-e> <Cmd>call pum#map#cancel()<CR>
    cnoremap <expr><CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR><CR>' : '<CR>'

    if !exists('b:prev_buffer_config')
        let b:prev_buffer_config = ddc#custom#get_buffer()
    endif
    call ddc#custom#patch_buffer('cmdlineSources', ['cmdline', 'cmdline-history', 'around', 'file'])

    autocmd User DDCCmdlineLeave ++once call CommandlinePost()
    autocmd InsertEnter <buffer> ++once call CommandlinePost()

    call ddc#enable_cmdline_completion()
endfunction

function! CommandlinePost() abort
    silent! cunmap <Tab>
    silent! cunmap <S-Tab>
    silent! cunmap <C-n>
    silent! cunmap <C-p>
    silent! cunmap <C-y>
    silent! cunmap <C-e>

    if exists('b:prev_buffer_config')
      call ddc#custom#set_buffer(b:prev_buffer_config)
      unlet b:prev_buffer_config
    else
      call ddc#custom#set_buffer({})
    endif
endfunction

call ddc#enable()

inoremap <expr><Tab> pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : '<Tab>'
inoremap <expr><S-Tab> pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : '<S-Tab>'
" inoremap <silent><expr> <Tab>
"     \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
"     \ (col('.') <= <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
"     \ '<Tab>' : ddc#manual_complete()
" inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-n> <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y> <Cmd>call pum#map#confirm()<CR>
inoremap <C-e> <Cmd>call pum#map#cancel()<CR>
inoremap <expr><CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'

" ddu.vim
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
    \ },
\ })

nnoremap <silent> ,ff :call <SID>DduStart('file_rec', v:true, v:false)<CR>
nnoremap <silent> ,l :call <SID>DduStart('line', v:true, v:false)<CR>
nnoremap <silent> ,b :call <SID>DduStart('buffer', v:true, v:false)<CR>
nnoremap ,r :DduGrep<Space>
nnoremap <silent> ,a :call <SID>DduGrepCWord()<CR>
nnoremap <silent> ,c :call <SID>DduStart('command_history', v:false, v:false)<CR>
nnoremap <silent> ,C :call <SID>DduStart('colorscheme', v:false, v:false)<CR>
nnoremap <silent> ,H :call <SID>DduStart('help', v:true, v:false)<CR>
nnoremap <silent> ,d :call <SID>DduStart('dirmark_custom', v:false, v:true)<CR>

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

call ddu#custom#patch_local('dirmark_custom', {
    \ 'uiParams': {
        \ 'ff': {
            \ 'startFilter': v:false,
        \ },
    \ },
    \ 'sources': [{'name': 'dirmark'}],
\ })

autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
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

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
    AutoCloseOff
    inoremap <buffer><silent> <CR> <Esc><Cmd>close<CR>
    nnoremap <buffer><silent> <CR> <Cmd>close<CR>
    nnoremap <buffer><silent> q <Cmd>close<CR>
endfunction

nnoremap <silent> ,fi :call <SID>DduFilerStart()<CR>
function! s:DduFilerStart() abort
    let s:win_pos = <SID>get_ddu_win_pos()
    call ddu#start({'name': 'filer', 'uiParams': {'filer': s:win_pos}, })
endfunction

call ddu#custom#patch_local('filer', {
    \ 'ui': 'filer',
    \ 'uiParams': {
        \ 'filer': {
            \ 'split': 'floating',
        \ },
    \},
    \ 'sources': [{'name': 'file',}],
    \ 'sourceOptions': {
        \ 'file': {'columns': ['filename']}
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
\ })

autocmd FileType ddu-filer call s:ddu_filer_my_settings()
function! s:ddu_filer_my_settings() abort
    nnoremap <buffer><expr> <CR> ddu#ui#filer#is_directory() ?
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow'})<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'open'})<CR>"
    nnoremap <buffer><silent> l <Cmd>call ddu#ui#filer#do_action('expandItem')<CR>
    nnoremap <buffer><silent> h <Cmd>call ddu#ui#filer#do_action('collapseItem')<CR>
    nnoremap <buffer><silent> <S-l> <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow'})<CR>
    nnoremap <buffer><silent> <S-h> <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow', 'params': {'path': '..'}})<CR>
    nnoremap <buffer><silent> x <Cmd>call ddu#ui#filer#do_action('toggleSelectItem')<CR>
    nnoremap <buffer><silent> c <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'cd'})<CR>
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

"about search
set hlsearch
set ignorecase "search both upper/lower case
set smartcase "distinguish upper/lower if search word include upper

"map jj to Esc
" inoremap <silent> jj <Esc>:<C-u>w<CR>
" cnoremap <silent> jj <Esc>:<C-u>w<CR>
" inoremap <silent> ｊｊ <Esc>:<C-u>w<CR>
" cnoremap <silent> ｊｊ <Esc>:<C-u>w<CR>
inoremap <silent> jj <Esc>
cnoremap <silent> jj <Esc>
inoremap <silent> ｊｊ <Esc>
cnoremap <silent> ｊｊ <Esc>
tnoremap <silent> jj <C-\><C-n>

"key bindings of Space + another
noremap <Leader>v g0vg$h
noremap <Leader>d g0vg$hx
noremap <Leader>y g0vg$hy

noremap <Leader>gv 0v$h
noremap <Leader>gd 0v$hx
noremap <Leader>gy 0v$hy

"space + h/l : move to beginning/end of the line
noremap <Leader>h g^
noremap <Leader>l g$
vnoremap <Leader>l g$h

noremap <Leader>gh ^
noremap <Leader>gl $
vnoremap <Leader>gl $h

"move to the bracket counterpart
noremap <Leader>b %

"tab
set tabstop=4 "set indent to four spaces
set autoindent
set expandtab
set shiftwidth=4

"command line mode
set wildmenu
set wildmode=longest:full,full
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
" cnoremap <C-p> <Up>
" cnoremap <C-n> <Down>
cnoremap <C-Space>h <Home>
cnoremap <C-Space><C-h> <Home>
cnoremap <C-Space>l <End>
cnoremap <C-Space><C-l> <End>
cnoremap <C-d> <Del>

"fzf

"include dotfiles for ag searching via fzf
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'source': 'ag --hidden --ignore .git -g ""'}), <bang>0)

command! -bang -nargs=* Ag
    \ call fzf#vim#grep(
    \ 'ag --column --color --hidden --ignore .git '.shellescape(<q-args>), 0,
    \ <bang>0 ? fzf#vim#with_preview('up:60%')
    \         : fzf#vim#with_preview('right:50%', '?'),
    \ <bang>0)

nnoremap <silent> ,g :GFiles<CR>
nnoremap <silent> ,G :GFiles?<CR>
nnoremap <silent> ,h :History<CR>

" Using floating windows of Neovim to start fzf
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'

  function! FloatingFZF()
    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.6)
    let opts = { 'relative': 'editor',
               \ 'row': (&lines - height) / 2,
               \ 'col': (&columns - width) / 2,
               \ 'width': width,
               \ 'height': height }

    let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

"folding
set foldmethod=manual
set foldcolumn=1
augroup viewGroup
    autocmd!
    autocmd BufWritePost ?* if expand('%') != '' && &buftype !~ 'nofile' | silent! mkview! | endif
    autocmd BufRead ?* if expand('%') != '' && &buftype !~ 'nofile' | silent! loadview | endif
augroup END

"etc.
set background=dark
set ruler
set number "display line number
set title "display file name
set showmatch "show corresponding bracket
set showcmd
set clipboard=unnamed
set mouse=a
set iminsert=0
set imsearch=-1
set incsearch
set t_Co=256
set wrap
set breakindent
set linebreak
set virtualedit+=block "enable to select place w/o character in <C-v> mode
set matchpairs+=<:>
set belloff=all
set noshowmode
set conceallevel=0
let g:vim_json_syntax_conceal = 0
set ambiwidth=single
set hidden
set scrolloff=1
set updatetime=150
set noequalalways
set lazyredraw
let g:indentLine_char = '¦'
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <MiddleMouse> <Nop>
noremap <2-MiddleMouse> <Nop>
noremap <3-MiddleMouse> <Nop>
noremap <4-MiddleMouse> <Nop>
tnoremap <S-Space> <Space>
nnoremap <S-k> <Nop>
cabbrev <expr> w] (getcmdtype() ==# ":" && getcmdline() ==# "w]") ? "w" : "w]"

if has('nvim')
    set pumblend=30
    set winblend=30
endif

augroup etcSettingsGroup
    autocmd!
    autocmd BufRead,BufNewFile *.toml set filetype=toml
    autocmd QuickFixCmdPost *grep* cwindow
augroup END

autocmd FileType qf call s:qf_my_settings()
function! s:qf_my_settings() abort
    nnoremap <buffer><silent> q :q<CR>
    nnoremap <buffer><silent> + <C-w>+
    nnoremap <buffer><silent> ; <C-w>+
    nnoremap <buffer><silent> - <C-w>-
    nnoremap <buffer><silent> p <CR><C-w>j
    nnoremap <buffer> j j
    nnoremap <buffer> k k
    nnoremap <buffer> gj gj
    nnoremap <buffer> gk gk
endfunction

nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [l :lprevious<CR>
nnoremap ]l :lnext<CR>

"always search in very magic mode
nnoremap / /\v

"lightline
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

"end lightline

"vim-anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
nmap # <Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)
set statusline=%{anzu#search_status()}
"hide highlight and anzu-status
nmap <silent><esc><esc> :nohlsearch<CR><esc> <Plug>(anzu-clear-search-status)

"buffer
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>

"vim-easymotion
let g:EasyMotion_smartcase = 1

"restart
let g:restart_sessionoptions = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

"vim-commentary
augroup vimCommentaryGroup
    autocmd!
    autocmd FileType matlab setlocal commentstring=%\ %s
augroup END

"encoding
set encoding=utf-8
set fileencodings=utf-8,sjis
set termencoding=utf-8
set fileformats=unix,dos

"markdown
augroup markdownGroup
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" Folding
augroup foldingGroup
    autocmd!
    autocmd ColorScheme * highlight Folded gui=bold guifg=LightGreen
augroup END

" restore vimsession
augroup RestoreVimSession
    autocmd!
    autocmd VimLeave * mks! ~/session.vim
augroup END

" show full path
command! Path echo expand("%:p")

filetype plugin indent on
syntax on
