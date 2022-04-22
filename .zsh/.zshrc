# Created by newuser for 5.8

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!\.git/*"'
export FZF_DEFAULT_OPTS="--height 50% --reverse --border --inline-info --preview 'head -100 {}'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Prompt Start
function get-prompt {
    SEP='\ue0b0'
    RESULT="%K{magenta}%n%k%F{magenta}%K{green}"`echo $SEP`"%f%k%K{green}%~%k"

    BRANCH=`git rev-parse --abbrev-ref HEAD 2>/dev/null`

    if [[ -n ${BRANCH} ]]; then
        RESULT=${RESULT}"%F{green}%K{cyan}"`echo $SEP`"%f%k%K{cyan}\ue725"${BRANCH}"%k%F{cyan}"`echo $SEP`"%f"
    else
        RESULT=${RESULT}"%F{green}"`echo $SEP`"%f"
    fi

    DATETIME="%F{cyan}(%D{%Y/%m/%d} %*)%f"

    echo "${RESULT} ${DATETIME}"
}

setopt prompt_subst
PROMPT='`get-prompt`
'
# Prompt End

# Completion Start
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
# Completion End

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Plugins
zinit light "zsh-users/zsh-completions"
zinit light "zsh-users/zsh-autosuggestions"
zinit light "zdharma/fast-syntax-highlighting"
# zinit light "b4b4r07/enhancd"
# zinit load zsh-users/zsh-syntax-highlighting
# End of Plugins

# Configs for Plugin
HISTFILE=${HOME}/.zsh_history
HISTSIZE=1000
SAVEHIST=100000
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
# End of Configs for Plugin

function select-history() {
    BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
    CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history
setopt +o nomatch
bindkey -v
bindkey "jj" vi-cmd-mode

function ccd() {
    dir=$(find * -type d | fzf --preview 'tree -C {} | head -100')
    if [ ${#dir} -gt 0 ]; then
        cd $dir
    fi
}

function fzfnvim() {
    file=$(find * -type f | fzf)
    if [ ${#file} -gt 0 ]; then
        nvim $file
    fi
}

function fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}

function fv() {
    local dir
    dir=$(find ${1:-.} -mindepth 1 \
        -not -iwholename *.git/objects* \
        -not -iwholename *.git/logs* \
        -not -iwholename *.git/refs* \
        -not -iwholename *.git/*HEAD* \
        -not -iwholename *.git/in* \
        2> /dev/null | fzf +m) &&
    vim "$dir"
}

. ~/z/z.sh

function isWinDir {
    case $PWD/ in
        /mnt/*) return $(true);;
        *) return $(false);;
    esac
}

function git {
    if [ "$(uname)" == 'Linux' -a !isWinDir ]
    then
        /usr/bin/git "$@"
    else
        git.exe "$@"
    fi
}

# for WSL2 GUI
if type ip > /dev/null; then
    export DISPLAY=`ip route | grep 'default via' | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`:0
fi
