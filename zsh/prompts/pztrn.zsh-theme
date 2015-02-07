# pztrn prompt theme
autoload -U add-zsh-hook

prompt_pztrn_help () {
    cat <<'EOF'

    prompt pztrn

    There is no colors to define

EOF
}

prompt_pztrn_setup () {
    local -A vars

    local p_date p_tty p_plat p_userpwd p_shlvlhist p_rc p_end p_win p_path

    autoload -U colors
    colors

    # Session-dependend colorizing.
    # Local will be black, remote - yellow.
    if [[ -n $SSH_TTY ]]; then
        vars['brackets_start']="%{$fg[yellow]%}[%{$reset_color%}"
        vars['brackets_end']="%{$fg[yellow]%}]%{$reset_color%}"
        vars['console']="$vars['brackets_start']SSH$vars['brackets_end']"
        vars['default_color']="%{$fg[cyan]%}"
    else
        vars['brackets_start']="%{$fg[black]%}[%{$reset_color%}"
        vars['brackets_end']="%{$fg[black]%}]%{$reset_color%}"
        vars['console']=""
        vars['default_color']="%{$fg[green]%}"
    fi

    p_date="$vars['brackets_start']$vars['default_color']%D{%a %Y/%m/%d %R}$vars['brackets_end']"
    p_tty="$vars['brackets_start']$vars['default_color']%l$vars['brackets_end']"
    p_plat="$vars['brackets_start']$vars['default_color']$(uname -r)$vars['brackets_end']"

    [[ -n "$WINDOW" ]] && p_win="$WINDOW"

    if [[ $USER == "root" ]]; then
        vars['usercolor']="%{$fg[red]%}"
    else
        vars['usercolor']="%{$fg[blue]%}"
    fi

    p_userpwd="$vars['brackets_start']$vars['usercolor']%n$reset_color@%{$fg[magenta]%}%M$vars['brackets_end']"

    p_shlvlhist="$vars['brackets_start']$vars['default_color']%B%h%b$vars['brackets_end']"
    p_rc="%(?..$vars['brackets_start']$fg[red]%?%1v$vars['brackets_end'])"
    p_end="$vars['usercolor']%#%{$reset_color%} "

    p_path="$vars['brackets_start']$vars['default_color'] %d $vars['brackets_end']"

    PROMPT="$p_date$p_tty$p_plat$p_userpwd$p_shlvlhist$p_rc
$vars['console']$p_path $p_end"
    RPROMPT="$p_date$p_tty$p_plat$p_userpwd$p_shlvlhist$p_rc
$vars['console']$p_path $p_end"
    PS2='%(4_.\.)%3_> %E'

    watch=all
    logcheck=5
    WATCHFMT="$vars['default_color']%n$reset_color from $fg[magenta]%M$reset_color has $vars['default_color']%a$reset_color (%l) at %T %W"

}

prompt_pztrn_setup "$@"
