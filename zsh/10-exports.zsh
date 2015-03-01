for config_file in `ls ${CONFIG_PATH}/zsh/exports | sort | grep zsh`; do
    source ${CONFIG_PATH}/zsh/exports/${config_file}
done