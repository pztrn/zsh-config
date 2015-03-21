for config_file in `ls ${CONFIG_PATH}/zsh/exports | sort`; do
    source ${CONFIG_PATH}/zsh/exports/${config_file}
done

if [ -d ${HOME}/.zsh-config.d/exports ]; then
    for config_file in `ls ${HOME}/.zsh-config.d/exports | sort`; do
        if [ -f ${HOME}/.zsh-config.d/exports/${config_file} ]; then
            source ${HOME}/.zsh-config.d/exports/${config_file}
        fi
    done
fi

