# Load user desired prompt.

autoload -Uz promptinit
promptinit

if [ "${PROMPT_THEME}" != "" ]; then
    if [ -f ${CONFIG_PATH}/zsh/prompts/${PROMPT_THEME}.zsh ]; then
        source ${CONFIG_PATH}/zsh/prompts/${PROMPT_THEME}.zsh
    else
        echo "Theme \"${PROMPT_THEME}\" could not be loaded. File does not exist or unreadable."
    fi
fi
