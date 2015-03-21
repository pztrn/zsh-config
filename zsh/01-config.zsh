# Configuration file loader.

if [ ! -d ${HOME}/.zsh-config.d/ ]; then
    cp -R ${CONFIG_PATH}/zsh/defaults/ ${HOME}/.zsh-config.d
    echo "Looks like it's a very first launch. So I've copied default config to '${HOME}/.zsh-config.d/'"
fi

for file in `find ${HOME}/.zsh-config.d/ -type f -depth 1 | sort`; do
    source ${HOME}/.zsh-config.d/${file}
done
