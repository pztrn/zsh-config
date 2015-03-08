# Configuration file loader.

if [ ! -d ${HOME}/.zsh-config.d/ ]; then
    cp -R ${CONFIG_PATH}/zsh/defaults/ ${HOME}/.zsh-config.d
    echo "Looks like it's a very first launch. So I've copied default config to '${HOME}/.zsh-config.d/'"
fi

for file in `ls ${HOME}/.zsh-config.d/ | sort`; do
    source ${HOME}/.zsh-config.d/${file}
done