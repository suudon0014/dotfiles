let $CACHE = expand('~/.cache')
if !($CACHE->isdirectory())
    call mkdir($CACHE, 'p')
endif

for s:plugin in [
    \ 'Shougo/dpp.vim',
    \ 'Shougo/dpp-ext-installer',
    \ 'Shougo/dpp-ext-toml',
    \ 'Shougo/dpp-protocol-git',
    \ 'denops/denops.vim',
    \ ]->filter({_, val -> &runtimepath !~# '/' .. val->fnamemodify(':t')})

    let s:dir = s:plugin->fnamemodify(':t')->fnamemodify(':p')
    if !(s:dir->isdirectory())
        let s:dir = $CACHE .. '/dpp/repos/github.com/' .. s:plugin
        if !(s:dir->isdirectory())
            execute '!git clone https://github.com/' .. s:plugin s:dir
        endif
    endif

    if s:plugin->fnamemodify(':t') ==# 'dpp.vim'
        execute 'set runtimepath^=' .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
    endif
endfor


const s:dpp_base      = '~/.cache/dpp'
const s:dpp_source    = '~/.cache/dpp/repos/github.com/Shougo/dpp.vim'
const s:dpp_config    = '~/dotfiles/.vim/settings/dpp_config.ts'
const s:denops_source = '~/.cache/dpp/repos/github.com/denops/denops.vim'

execute 'set runtimepath^=' .. s:dpp_source

if dpp#min#load_state(s:dpp_base)
    execute 'set runtimepath^=' .. s:denops_source
    autocmd User DenopsReady call dpp#make_state(s:dpp_base, s:dpp_config)
endif

call dpp#async_ext_action('installer', 'install')
