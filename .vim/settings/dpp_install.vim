set nocompatible

let $CACHE = expand('~/.cache')
if !($CACHE->isdirectory())
    call mkdir($CACHE, 'p')
endif

let s:dpp_plugin_list = [
    \ 'Shougo/dpp.vim',
    \ 'Shougo/dpp-ext-installer',
    \ 'Shougo/dpp-ext-lazy',
    \ 'Shougo/dpp-ext-toml',
    \ 'Shougo/dpp-protocol-git',
    \ ]

" Installing plugins required for dpp.vim and setting runtimepath.
function! s:InitDppPlugins(plugins) abort
    for plugin in a:plugins->filter({_, val -> &runtimepath !~# '/' .. val->fnamemodify(':t')})
        let dir = plugin->fnamemodify(':t')->fnamemodify(':p')

        " Any plugins which not exists in current or cache directory will git-clone in cache directory.
        if !(dir->isdirectory())
            let dir = $CACHE .. '/dpp/repos/github.com/' .. plugin
            if !(dir->isdirectory())
                execute '!git clone https://github.com/' .. plugin dir
            endif
        endif

        " Add plugins to runtimepath after deleting trailing slash or backslash.
        execute 'set runtimepath^=' .. dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
    endfor
endfunction

call <SID>InitDppPlugins(s:dpp_plugin_list)

let g:denops#debug = 1

const s:dpp_base      = '~/.cache/dpp'->expand()
const s:dpp_config    = '~/dotfiles/.vim/settings/dpp_config.ts'->expand()
" const s:denops_source = '~/.cache/dpp/repos'

if dpp#min#load_state(s:dpp_base)
    call <SID>InitDppPlugins(['vim-denops/denops.vim'])
    augroup DppAuGroup
        autocmd!
        autocmd User DenopsReady call dpp#make_state(s:dpp_base, s:dpp_config)
    augroup END
endif

call dpp#async_ext_action('installer', 'install')

filetype indent plugin on

if has('syntax')
    syntax on
endif
