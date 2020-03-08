function fish_prompt --description 'Write out the prompt'
    set user (set_color white)(set_color -b green)(echo $USER)
    set sep_user (set_color green)(set_color -b cyan)(echo \ue0b0)
    set pwd (set_color white)(set_color -b cyan)(prompt_pwd)
    set sep_pwd (set_color cyan)(echo \ue0b0)

    set branch (__fish_git_prompt)
    if string length -q -- $branch
        set sep_pwd (set_color -b yellow)$sep_pwd
        set branch (string trim -l $branch)
        set branch (string trim -c '(' $branch)
        set branch (string trim -c ')' $branch)
        set branch (set_color white)(set_color -b yellow)(echo \ue725)$branch
        set sep_branch (set_color yellow)(set_color -b black)(echo \ue0b0)
    else
        set sep_pwd (set_color -b black)$sep_pwd
        set sep_branch (set_color white)(set_color -b black)(echo '')
    end

    printf '%s%s%s%s%s%s' $user $sep_user $pwd $sep_pwd $branch $sep_branch
end
