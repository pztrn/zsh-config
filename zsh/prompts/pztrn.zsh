# pztrn prompt theme
autoload -U add-zsh-hook

# Common vars array.
declare -A vars
# Prompt parts.
declare p_date p_tty p_plat p_userpwd p_shlvlhist p_rc p_end p_win p_path p_gitinfo

prompt_pztrn_help () {
    cat <<'EOF'

    prompt pztrn

    There is no colors to define

EOF
}

prompt_pztrn_setup () {
    emulate -L zsh
    precmd_functions=(${precmd_functions[@]} "prompt_pztrn_gitinfo" "prompt_pztrn_createprompt")

    # Session-dependend colorizing.
    # Local will be black, remote - yellow.
    if [[ -n $SSH_TTY ]]; then
        vars['brackets_start']="%{$fg[yellow]%}[%{$reset_color%}"
        vars['brackets_end']="%{$fg[yellow]%}]%{$reset_color%}"
        vars['console']="$vars['brackets_start']SSH$vars['brackets_end']"
        vars['default_color']="%{$fg[cyan]%}"
    else
        vars['brackets_start']="%{$reset_color%}%{$fg[gray]%}[%{$reset_color%}"
        vars['brackets_end']="%{$reset_color%}%{$fg[gray]%}]%{$reset_color%}"
        vars['console']=""
        vars['default_color']="%{$fg[green]%}"
    fi

    p_date="$vars['brackets_start']$vars['default_color']%D{%a %Y/%m/%d %R}$vars['brackets_end']"
    p_tty="$vars['brackets_start']$vars['default_color']%l$vars['brackets_end']"
    p_plat="$vars['brackets_start']$vars['default_color']$(uname -r)$vars['brackets_end']"

    [[ -n "$WINDOW" ]] && p_win="$WINDOW"

    if [[ "$USER" == "root" ]]; then
        vars['usercolor']="%{$fg[red]%}"
    else
        vars['usercolor']="%{$fg[blue]%}"
    fi

    p_hostname=$(hostname -f)
    p_userpwd="$vars['brackets_start']$vars['usercolor']%n$reset_color@%{$fg[magenta]%}$p_hostname$vars['brackets_end']"

    p_shlvlhist="$vars['brackets_start']$vars['default_color']%B%h%b$vars['brackets_end']"
    p_rc="%(?..$vars['brackets_start']$fg[red]%?%1v$vars['brackets_end'])"
    p_end="$vars['usercolor']%#%{$reset_color%} "

    p_path="$vars['brackets_start']$vars['default_color'] %d $vars['brackets_end']"

    # Initial prompt creation. On every cd it will be recreated with
    # prompt_pztrn_createprompt function.
    PROMPT="$p_date$p_tty$p_plat$p_userpwd$p_shlvlhist$p_rc$p_gitinfo
$vars['console']$p_path $p_end"
    RPROMPT="$p_date$p_tty$p_plat$p_userpwd$p_shlvlhist$p_rc$p_gitinfo
$vars['console']$p_path $p_end"
    PS2='%(4_.\.)%3_> %E'

    watch=all
    logcheck=5
    WATCHFMT="$fg[green]%n$reset_color from $fg[magenta]%M$reset_color has $fg[green]%a$reset_color (%l) at %T %W"

}

prompt_pztrn_gitinfo()
{
    # Git repository information.
    # Depends on 'gitinfo' application.
    gitinfo_present=`declare -f gitinfo_check`
    if [ $gitinfo_present ]; then
        gitinfo_check
        #echo $?
        if [[ $? -eq 0 ]]; then
            p_gitinfo_branch="$vars['brackets_start']$vars['usercolor']${GITINFO_BRANCH}$reset_color$vars['brackets_end']"
            p_gitinfo_commit="$vars['brackets_start']%{$fg[magenta]%}${GITINFO_COMMIT_SHORTID}$reset_color (%{$fg[cyan]%}${GITINFO_COMMIT_COUNT}$reset_color)$vars['brackets_end']"
            p_gitinfo_remotes="$vars['brackets_start']%{$fg[green]%}${GITINFO_REMOTES} remote(s)$reset_color$vars['brackets_end']"
            p_gitinfo_files="$vars['brackets_start']%{$fg[green]%}${GITINFO_NEW_FILES}$reset_color new, %{$fg[yellow]%}${GITINFO_MODIFIED_FILES}$reset_color modified, %{$fg[red]%}${GITINFO_DELETED_FILES}$reset_color deleted, %{$fg[gray]%}${GITINFO_UNTRACKED_COUNT}$reset_color untracked$vars['brackets_end']"
            p_gitinfo=$'\n'"$p_gitinfo_branch$p_gitinfo_commit$p_gitinfo_files$p_gitinfo_remotes"
        else
            p_gitinfo=""
        fi
    fi
}

prompt_pztrn_createprompt()
{
    PROMPT="$p_date$p_tty$p_plat$p_userpwd$p_shlvlhist$p_rc$p_gitinfo
$vars['console']$p_path $p_end"
    RPROMPT="$p_date$p_tty$p_plat$p_userpwd$p_shlvlhist$p_rc$p_gitinfo
$vars['console']$p_path $p_end"
}

prompt_pztrn_setup
