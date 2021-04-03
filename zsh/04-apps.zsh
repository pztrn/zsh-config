# Load enabled apps.
for app in ${ENABLED_APPS[@]}; do
    if [ ! -f "${CONFIG_PATH}/zsh/apps/${app}.app.zsh" ]; then
        error 0 "Application '${app}' doesn't exist"
    else
        source "${CONFIG_PATH}/zsh/apps/${app}.app.zsh"
        # chpwd injecting.
        chpwd_injector=`declare -f ${app}_chpwd`
        if [ $chpwd_injector ]; then
            ${app}_chpwd
        fi
    fi
    #export ${app}="${app}_main"
done
