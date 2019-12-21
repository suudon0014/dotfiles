cd nvim
mklink init.vim %HOME%\dotfiles\.vim\.vimrc
mklink ginit.vim %HOME%\dotfiles\.vim\.gvimrc

cd %HOME%
mklink .vimrc %HOME%\dotfiles\.vim\.vimrc
mklink .gvimrc %HOME%\dotfiles\.vim\.gvimrc

cd %HOME%\dotfiles
