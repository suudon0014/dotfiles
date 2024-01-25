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
    \ 'vim-denops/denops.vim'
    \ ]

" Installing plugins required for dpp.vim and setting runtimepath.
for s:plugin in s:dpp_plugin_list->filter({_, val -> &runtimepath !~# '/' .. val->fnamemodify(':t')})
    let s:dir = s:plugin->fnamemodify(':t')->fnamemodify(':p')

    " Any plugins which not exists in current or cache directory will git-clone in cache directory.
    if !(s:dir->isdirectory())
        let s:dir = $CACHE .. '/dpp/repos/github.com/' .. s:plugin
        if !(s:dir->isdirectory())
            execute '!git clone https://github.com/' .. s:plugin s:dir
        endif
    endif

    " Add plugins to runtimepath after deleting trailing slash or backslash.
    execute 'set runtimepath^=' .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endfor

let g:denops#debug = 1

const s:dpp_base      = '~/.cache/dpp'
const s:dpp_source    = '~/.cache/dpp/repos/github.com/Shougo/dpp.vim'
const s:dpp_config    = '~/dotfiles/.vim/settings/dpp_config.ts'
const s:denops_source = '~/.cache/dpp/repos/github.com/vim-denops/denops.vim'

if dpp#min#load_state(s:dpp_base)
    execute 'set runtimepath^=' .. s:denops_source
    autocmd User DenopsReady call dpp#make_state(s:dpp_base, s:dpp_config)
endif

call dpp#async_ext_action('installer', 'install')
