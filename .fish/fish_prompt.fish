function fish_prompt --description 'Write out the prompt'
    set user (set_color white)(set_color -b brmagenta)(echo $USER)
    set sep_user (set_color brmagenta)(set_color -b brgreen)(echo \ue0b0)
    set pwd (set_color white)(set_color -b brgreen)(prompt_pwd)
    set sep_pwd (set_color brgreen)(echo \ue0b0)

    set branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if string length -q -- $branch
        set sep_pwd (set_color -b brcyan)$sep_pwd
        set branch (string trim -l $branch)
        set branch (string trim -c '(' $branch)
        set branch (string trim -c ')' $branch)
        set branch (set_color white)(set_color -b brcyan)(echo \ue725)$branch
        set sep_branch (set_color brcyan)(set_color -b black)(echo \ue0b0)
    else
        set sep_pwd (set_color -b black)$sep_pwd
        set sep_branch (set_color white)(set_color -b black)(echo '')
    end

    printf '%s%s%s%s%s%s' $user $sep_user $pwd $sep_pwd $branch $sep_branch
end
