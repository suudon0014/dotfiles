# Created by newuser for 5.8

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function get-prompt {
    SEP='\ue0b0'
    RESULT="%K{magenta}%n%k%F{magenta}%K{green}"`echo $SEP`"%f%k%K{green}%~%k"

    BRANCH=`git rev-parse --abbrev-ref HEAD 2>/dev/null`

    if [[ -n ${BRANCH} ]]; then
        RESULT=${RESULT}"%F{green}%K{cyan}"`echo $SEP`"%f%k%K{cyan}"${BRANCH}"%k%F{cyan}"`echo $SEP`"%f"
    else
        RESULT=${RESULT}"%F{green}"`echo $SEP`"%f"
    fi

    echo "${RESULT}"
}

setopt prompt_subst
PROMPT='`get-prompt`'
