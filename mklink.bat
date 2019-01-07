cd nvim
mklink init.vim %HOME%\dotfiles\.vimrc
mklink ginit.vim %HOME%\dotfiles\.gvimrc

cd %HOME%
mklink .vimrc %HOME%\dotfiles\.vimrc
mklink .gvimrc %HOME%\dotfiles\.gvimrc

cd %HOME%\dotfiles
