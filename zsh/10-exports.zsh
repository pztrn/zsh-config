# Some default exports. They could be based on configuration variables.
for config_file in `find ${CONFIG_PATH}/zsh/exports -type f -exec basename {} \; | sort`; do
    source "${CONFIG_PATH}/zsh/exports/${config_file}"
done

# We should import user-specific exports and use them.
if [ -d ${HOME}/.zsh-config.d/exports ]; then
    for config_file in `find ${HOME}/.zsh-config.d/exports -type f -exec basename {} \; | sort`; do
        if [ -f "${HOME}/.zsh-config.d/exports/${config_file}" ]; then
            source "${HOME}/.zsh-config.d/exports/${config_file}"
        fi
    done
fi

