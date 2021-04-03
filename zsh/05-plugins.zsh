# Load enabled plugins.
for plugin in "${ENABLED_PLUGINS[@]}"; do
    if [ ! -f "${CONFIG_PATH}/zsh/plugins/${plugin}.plugin.zsh" ]; then
        error 0 "Plugin '${plugin}' doesn't exist"
    else
        source "${CONFIG_PATH}/zsh/plugins/${plugin}.plugin.zsh"
        # chpwd injecting.
        chpwd_injector=`declare -f ${plugin}_chpwd`
        if [ $chpwd_injector ]; then
            ${plugin}_chpwd
        fi
    fi
done
