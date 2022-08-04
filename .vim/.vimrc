filetype off
filetype plugin indent off

source ~/dotfiles/.vim/dein_rc.vim

"load separated setting files
set runtimepath+=~/dotfiles/.vim/
runtime! settings/*.vim
runtime! lua/mappings.lua
runtime! lua/sets.lua

augroup myAuGroup
    autocmd!
    autocmd BufWritePost ?* if expand('%') != '' && &buftype !~ 'nofile' | silent! mkview! | endif
    autocmd BufRead ?* if expand('%') != '' && &buftype !~ 'nofile' | silent! loadview | endif
    autocmd QuickFixCmdPost *grep* cwindow
    autocmd VimLeave * mks! ~/session.vim
augroup END

" show full path
command! Path echo expand("%:p")

filetype plugin indent on
syntax on
