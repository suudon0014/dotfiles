" configs about dein.vim

" global parameters
let g:dein#install_github_api_token = $GITHUB_API_TOKEN
let g:dein#install_max_processes = 8
let g:dein#install_process_timeout = 1800
let g:dein#install_progress_type = 'floating'


"installing directory
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
    let s:rc_dir = expand('~/dotfiles/.vim/toml')
    let s:toml = s:rc_dir . '/dein.toml'
    let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'
    let s:submode_lazy_toml = s:rc_dir . '/dein_submode_lazy.toml'
    let s:colorscheme_lazy_toml = s:rc_dir . '/dein_colorscheme_lazy.toml'
    let s:lightline_lazy_toml = s:rc_dir . '/dein_lightline_lazy.toml'

    "read and cache the toml files
    call dein#load_toml(s:toml, {'lazy':0})
    call dein#load_toml(s:lazy_toml, {'lazy':1})
    call dein#load_toml(s:submode_lazy_toml, {'lazy':1})
    call dein#load_toml(s:colorscheme_lazy_toml, {'lazy':1})
    call dein#load_toml(s:lightline_lazy_toml, {'lazy':1})

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
        call dein#recache_runtimepath()
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
    call dein#recache_runtimepath()
    echo dein#get_updates_log()
endfunction

DeinInstall
autocmd VimEnter * call dein#call_hook('post_source')
