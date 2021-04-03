# Configuration file loader.
log 1 "Checking for configuration consistency..."
for file in `find ${CONFIG_PATH}/zsh/defaults/ -maxdepth 1 -type f -exec basename {} \; | sort`; do
    if [ ! -f "${HOME}/.zsh-config.d/${file}" ]; then
        cp "${CONFIG_PATH}/zsh/defaults/${file}" "${HOME}/.zsh-config.d/${file}"
        log 0 "New configuration file '${file}' copied to your home directory (${HOME}/.zsh-config.d/)."
        log 0 "Don't forget to take a look and configure, if neccessary!"
    fi
done

if [ ! -d ${HOME}/.zsh-config.d/ ]; then
    log 1 "Copying configuration to user's home directory..."
    cp -R "${CONFIG_PATH}/zsh/defaults/" ${HOME}/.zsh-config.d
    echo "Looks like it's a very first launch. So I've copied default config to '${HOME}/.zsh-config.d/'"
fi

for file in `find ${HOME}/.zsh-config.d/ -maxdepth 1 -type f -exec basename {} \; | sort`; do
    log 1 "Loading configuration file: ${file}"
    source "${HOME}/.zsh-config.d/${file}"
done
