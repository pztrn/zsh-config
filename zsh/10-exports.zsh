for config_file in `ls ${CONFIG_PATH}/zsh/exports | sort`; do
    source ${CONFIG_PATH}/zsh/exports/${config_file}
done

for config_file in `ls ${HOME}/.zsh-config.d/exports | sort`; do
    source ${HOME}/.zsh-config.d/exports/${config_file}
done

