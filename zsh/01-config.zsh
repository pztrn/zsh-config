# Configuration file loader.
if [ ! -d ${HOME}/.zsh-config.d/ ]; then
    cp -R "${CONFIG_PATH}/zsh/defaults/" ${HOME}/.zsh-config.d
    echo "Looks like it's a very first launch. So I've copied default config to '${HOME}/.zsh-config.d/'"
fi

for file in `find ${HOME}/.zsh-config.d/ -maxdepth 1 -type f -exec basename {} \; | sort`; do
    source "${HOME}/.zsh-config.d/${file}"
done
