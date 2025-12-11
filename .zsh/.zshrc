# Created by newuser for 5.8

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!\.git/*"'
export FZF_DEFAULT_OPTS="--height 50% --reverse --border --inline-info --preview 'head -100 {}'"

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
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma-continuum/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-bin-gem-node

### End of Zinit's installer chunk

# Aliases
alias ll='ls -laht --color --time-style=long-iso'
alias la='ls -a --color --time-style=long-iso'
alias lg='lazygit'
alias dc='docker compose'
alias gst='git status'
alias gd='git diff'
alias ga='git add'
alias gap='git add -p'
alias gp='git push'
alias gb='git branch'
alias gba='git branch -a'
alias gsw='git switch'
alias gg='git graph'
alias lf='llm -u -m gemini-2.0-flash-exp'
alias vi='nvim'
alias vim='nvim'
alias fzfnvim='nvim $(/bin/find . -path ./.git -prune -o -type f -print | fzf)'
alias tree='tree -C'

# Plugins
zinit light "zsh-users/zsh-completions"
zinit light "zsh-users/zsh-autosuggestions"
zinit light "zsh-users/zsh-syntax-highlighting"
# zinit light "zdharma-continuum/fast-syntax-highlighting"
# zinit light "b4b4r07/enhancd"
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
setopt +o nomatch
setopt hist_ignore_all_dups
bindkey -v
bindkey "^R" select-history
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

# cd using fzf
function fzd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}

# open file in vim using fzf
function fzv() {
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

function unixdate() {
    date --date='@'$1 +'%Y/%m/%d %H:%M:%S'
}

# for WSL2
if [ -e /etc/init.d/docker ]; then
    sudo /etc/init.d/docker start
fi

# for WSL2 GUI
if type ip > /dev/null; then
    # export DISPLAY=`ip route | grep 'default via' | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`:0
    export DISPLAY=:0.0
fi

export LIBGL_ALWAYS_SOFTWARE=1

# OSC 133
_prompt_executing=""
function __prompt_precmd() {
    local ret="$?"
    if test "$_prompt_executing" != "0"
    then
      _PROMPT_SAVE_PS1="$PS1"
      _PROMPT_SAVE_PS2="$PS2"
      PS1=$'%{\e]133;P;k=i\a%}'$PS1$'%{\e]133;B\a\e]122;> \a%}'
      PS2=$'%{\e]133;P;k=s\a%}'$PS2$'%{\e]133;B\a%}'
    fi
    if test "$_prompt_executing" != ""
    then
       printf "\033]133;D;%s;aid=%s\007" "$ret" "$$"
    fi
    printf "\033]133;A;cl=m;aid=%s\007" "$$"
    _prompt_executing=0
}
function __prompt_preexec() {
    PS1="$_PROMPT_SAVE_PS1"
    PS2="$_PROMPT_SAVE_PS2"
    printf "\033]133;C;\007"
    _prompt_executing=1
}
preexec_functions+=(__prompt_preexec)
precmd_functions+=(__prompt_precmd)
