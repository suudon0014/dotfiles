# Created by newuser for 5.8

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

SEP1='\ue0b0'
PROMPT="%K{magenta}%n%k%F{magenta}%K{green}`echo $SEP1`%f%k%K{green}%~%k%F{green}`echo $SEP1`%f%k"
