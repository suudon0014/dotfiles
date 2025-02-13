" configs about dein.vim

"installing directory
let s:dein_dir = expand('~/.cache/dein')

" global parameters
let g:dein#install_github_api_token = $GITHUB_API_TOKEN
let g:dein#install_max_processes = 32
let g:dein#install_process_timeout = 1800
let g:dein#install_progress_type = 'floating'
let g:dein#types#git#clone_depth = 1
let g:dein#install_log_filename = s:dein_dir . '/install_log.log'

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
if dein#min#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    "create plugins list file using TOML format beforehand
    let s:rc_dir = expand('~/dotfiles/.vim/toml')
    let s:dein_toml = s:rc_dir . '/dein.toml'
    let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'
    let s:ddc_toml = s:rc_dir . '/ddc_lazy.toml'
    let s:ddu_toml = s:rc_dir . '/ddu_lazy.toml'
    let s:dpp_toml = s:rc_dir . '/dpp_lazy.toml'
    let s:colorscheme_toml = s:rc_dir . '/colorscheme_lazy.toml'
    let s:lightline_toml = s:rc_dir . '/lightline_lazy.toml'
    let s:markdown_toml = s:rc_dir . '/markdown_lazy.toml'
    let s:python_toml = s:rc_dir . '/python_lazy.toml'
    let s:treesitter_toml = s:rc_dir . '/treesitter_lazy.toml'

    "read and cache the toml files
    call dein#load_toml(s:dein_toml, {'lazy':0})
    call dein#load_toml(s:lazy_toml, {'lazy':1})
    call dein#load_toml(s:ddc_toml, {'lazy':1})
    call dein#load_toml(s:ddu_toml, {'lazy':1})
    call dein#load_toml(s:dpp_toml, {'lazy':1})
    call dein#load_toml(s:colorscheme_toml, {'lazy':1})
    call dein#load_toml(s:lightline_toml, {'lazy':1})
    call dein#load_toml(s:markdown_toml, {'lazy':1})
    call dein#load_toml(s:python_toml, {'lazy':1})
    call dein#load_toml(s:treesitter_toml, {'lazy':1})

    "end the setting
    call dein#end()
    call dein#save_state()
endif


" functions and commands
"install if there are plugins not installed
command! DeinInstall :call s:deinInstall()
function! s:deinInstall()
    if dein#check_install()
        call dein#install()
    else
        echo "All plugins have already installed."
    endif
endfunction

"work only when delete plugins
command! DeinClean :call s:deinClean()
function! s:deinClean()
    if len(dein#check_clean()) > 0
        echo "Processing..."
        call map(dein#check_clean(), "delete(v:val, 'rf')")
        RecacheRtp
        echo "DeinClean completed."
    else
        echo "There's no disabled plugins."
    endif
endfunction

"update plugins using Github GraphQL API
command! DeinUpdate :call s:deinUpdate()
function! s:deinUpdate()
    if !empty(g:dein#install_github_api_token)
        call dein#check_update(v:true)
        echo "DeinUpdate completed."
        echo dein#get_updates_log()
    else
        echo "[Error] Set $GITHUB_API_TOKEN and restart vim for DeinUpdate to work."
    endif
endfunction

" update all plugins strictly but slower than :DeinUpdate
command! DeinStrictUpdate :call s:deinStrictUpdate()
function! s:deinStrictUpdate()
    call dein#update()
    RecacheRtp
    echo dein#get_updates_log()
endfunction

DeinInstall
autocmd VimEnter * call dein#call_hook('post_source')

command! RecacheRtp :call s:recacheRuntimePath()
function! s:recacheRuntimePath()
    call dein#recache_runtimepath()
    call ddc#set_static_import_path()
    call ddu#set_static_import_path()
endfunction

