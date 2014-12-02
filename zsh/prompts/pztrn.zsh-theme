# pztrn prompt theme
autoload -U add-zsh-hook

prompt_pztrn_help () {
    cat <<'EOF'

    prompt pztrn [<color1> [<color2> [<color3> [<color4> [<color5>]]]]]

    defaults are red, cyan, green, yellow, and white, respectively.

EOF
}

prompt_pztrn_setup () {
    local -a pcc
    local -A pc
    local p_date p_tty p_plat p_ver p_userpwd p_apm p_shlvlhist p_rc p_end p_win

    autoload -Uz vcs_info

    pcc[1]=${1:-${${SSH_CLIENT+'yellow'}:-'red'}}
    pcc[2]=${2:-'cyan'}
    pcc[3]=${3:-'green'}
    pcc[4]=${4:-'yellow'}
    pcc[5]=${5:-'white'}

    pc['\[']="%F{$pcc[1]}["
    pc['\]']="%F{$pcc[1]}]"
    pc['<']="%F{$pcc[1]}<"
    pc['>']="%F{$pcc[1]}>"
    pc['\(']="%F{$pcc[1]}("
    pc['\)']="%F{$pcc[1]})"

    p_date="$pc['\[']%F{$pcc[2]}%D{%a %y/%m/%d %R %Z}$pc['\]']"
    p_tty="$pc['\[']%F{$pcc[3]}%l$pc['\]']"
    p_plat="$pc['\[']%F{$pcc[2]}$(uname -r)$pc['\]']"
    p_ver="$pc['\[']%F{$pcc[2]}${ZSH_VERSION}$pc['\]']"

    [[ -n "$WINDOW" ]] && p_win="$pc['\(']%F{$pcc[4]}$WINDOW$pc['\)']"

    p_userpwd="$pc['\[']%F{$pcc[5]}User:%F{$pcc[3]} %n$pc['\]']$pc['\[']%F{$pcc[5]}Host:%F{$pcc[3]} %M$pc['\]']"

    p_shlvlhist="$pc['\[']%F{$pcc[3]}%B%h%b$pc['\]']"
    p_rc="%(?..[%?%1v] )"
    p_end="%f%B%#%b "
    p_path="$pc['\[']%F{$pcc[4]} %d $pc['\]']"

    zle_highlight[(r)default:*]=default:$pcc[2]

    prompt="$p_date$p_tty$p_plat$p_ver$p_userpwd$p_shlvlhist
$p_path $p_end"
    PS2='%(4_.\.)%3_> %E'

    add-zsh-hook precmd prompt_pztrn_precmd
}

prompt_pztrn_precmd () {
    setopt noxtrace noksharrays localoptions
    local exitstatus=$?
    local git_dir git_ref

    psvar=()
    [[ $exitstatus -ge 128 ]] && psvar[1]=" $signals[$exitstatus-127]" ||
	psvar[1]=""

    [[ -o interactive ]] && jobs -l

    vcs_info
    [[ -n $vcs_info_msg_0_ ]] && psvar[2]="$vcs_info_msg_0_" || psvar[2]="NO"
}

prompt_pztrn_setup "$@"
