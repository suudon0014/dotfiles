#!/bin/sh

set -e

DOTFILES=${HOME}/dotfiles
source ${DOTFILES}/install_func.sh

XDG_CONFIG_HOME=${HOME}/.config
mkdir -p ${XDG_CONFIG_HOME}
mkdir -p ${XDG_CONFIG_HOME}/nvim

# for Windows
if [ "$(expr substr $(uname -s) 1 4)" == "MSYS"\
     -o "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
     setx XDG_CONFIG_HOME ${XDG_CONFIG_HOME}

    # Neovim
    NeovimRoot=C:/Neovim
    setx VIM ${NeovimRoot}/share/nvim
    setx VIMRUNTIME ${NeovimRoot}/share/nvim/runtime

    # Vim
    # VimRoot=C:/Vim
    # setx VIM ${VimRoot}
    # setx VIMRUNTIME ${VimRoot}/vim82

# for Linux
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    export XDG_CONFIG_HOME=${XDG_CONFIG_HOME}
else
    echo OS CHECK ERROR!
fi

ln -sfv ${DOTFILES}/.vim/.vimrc ${XDG_CONFIG_HOME}/nvim/init.vim
ln -sfv ${DOTFILES}/.vim/.gvimrc ${XDG_CONFIG_HOME}/nvim/ginit.vim
ln -sfv ${DOTFILES}/.vim/.vimrc ${HOME}/.vimrc
ln -sfv ${DOTFILES}/.vim/.gvimrc ${HOME}/.gvimrc

ln -sfv ${DOTFILES}/.gitconfig ${HOME}/.gitconfig

echo -e "\n[Install commands using npm]"
if !(type "npm" > /dev/null 2>&1); then
    echo "npm is not installed."
else
    echo "npm is installed."

    install_by_npm "bash-language-server"
    install_by_npm "vim-language-server"
fi
