#!/bin/bash

set -e

DOTFILES=~/dotfiles
source ${DOTFILES}/install_func.sh

XDG_CONFIG_HOME=~/.config
mkdir -p ${XDG_CONFIG_HOME}
mkdir -p ${XDG_CONFIG_HOME}/nvim

# for Windows
if [ "$(expr substr $(uname -s) 1 4)" == "MSYS"\
     -o "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
     setx LANG "ja_JP.UTF-8"
     setx XDG_CONFIG_HOME ${XDG_CONFIG_HOME}
     setx MSYS winsymlinks:nativestrict
     setx MSYS2_PATH_TYPE inherit

    # Neovim
    NeovimRoot=C:/Neovim
    setx VIM ${NeovimRoot}/share/nvim
    setx VIMRUNTIME ${NeovimRoot}/share/nvim/runtime

    # Vim
    # VimRoot=C:/Vim
    # setx VIM ${VimRoot}
    # setx VIMRUNTIME ${VimRoot}/vim82

    # Create python venvs for neovim
    if [ ! -d ~/.venv ]; then
        echo -e "\nPython venvs for neovim is not found.\nStart creating..."
        mkdir ~/.venv && cd ~/.venv

        # python2 venv for neovim
        python -m virtualenv neovim2
        source neovim2/Scripts/activate
        pip install -U neovim
        deactivate

        # python3 venv for neovim
        python3 -m venv neovim3 --without-pip
        curl -kL https://bootstrap.pypa.io/get-pip.py > get-pip.py
        source neovim3/Scripts/activate
        python get-pip.py
        pip install -U neovim python-language-server compiledb
        deactivate

        cd ~
    else
        echo -e "\nPython venvs for neovim is found."
    fi

# for Linux
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    export XDG_CONFIG_HOME=${XDG_CONFIG_HOME}
else
    echo OS CHECK ERROR!
fi

ln -sfv ${DOTFILES}/.vim/.vimrc ${XDG_CONFIG_HOME}/nvim/init.vim
ln -sfv ${DOTFILES}/.vim/.gvimrc ${XDG_CONFIG_HOME}/nvim/ginit.vim
ln -sfv ${DOTFILES}/.vim/.vimrc ~/.vimrc
ln -sfv ${DOTFILES}/.vim/.gvimrc ~/.gvimrc

ln -sfv ${DOTFILES}/.gitconfig ~/.gitconfig

ln -sfv ${DOTFILES}/.fish/config.fish ${XDG_CONFIG_HOME}/fish/config.fish
ln -sfv ${DOTFILES}/.fish/fish_prompt.fish ${XDG_CONFIG_HOME}/fish/functions/fish_prompt.fish

echo -e "\n[Install commands using npm]"
if !(type "npm" > /dev/null 2>&1); then
    echo "npm is not installed."
else
    echo "npm is installed."

    install_by_npm "bash-language-server"
    install_by_npm "vim-language-server"
    install_by_npm "typescript-language-server"
fi
