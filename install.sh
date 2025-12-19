#!/bin/bash

set -e

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
# for Linux
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    export XDG_CONFIG_HOME=${XDG_CONFIG_HOME}
else
    echo OS CHECK ERROR!
fi

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# vim
ln -sfv ${DOTFILES}/.vim/.vimrc ${XDG_CONFIG_HOME}/nvim/init.vim
ln -sfv ${DOTFILES}/.vim/.gvimrc ${XDG_CONFIG_HOME}/nvim/ginit.vim
ln -sfv ${DOTFILES}/.vim/.vimrc ~/.vimrc
ln -sfv ${DOTFILES}/.vim/.gvimrc ~/.gvimrc

# git
ln -sfv ${DOTFILES}/.gitconfig ~/.gitconfig
ln -sfv ${DOTFILES}/.git_commit_template ~/.git_commit_template

# etc.
ln -sfv ${DOTFILES}/.zsh/.zshrc ~/.zshrc
ln -sfv ${DOTFILES}/.latexmkrc ~/.latexmkrc
mkdir -p ${XDG_CONFIG_HOME}/lazygit
ln -sfv ${DOTFILES}/lazygit/config.yml ${XDG_CONFIG_HOME}/lazygit/config.yml

# scoop
# SCOOP_DIR=${DOTFILES}/scoop
# SCOOP_CONFIG_DIR=${XDG_CONFIG_HOME}/scoop
# ln -sfv ${SCOOP_DIR}/scoop_config.json ${SCOOP_CONFIG_DIR}/config.json
# scoop import ${SCOOP_DIR}/scoopfile.json
# ln -sfv ${SCOOP_DIR}/windows_terminal_settings.json ~/scoop/persist/windows-terminal/settings/settings.json
# mkdir -p ${APPDATA}/bat
# ln -sfv ${SCOOP_DIR}/bat_config ${APPDATA}/bat/config

