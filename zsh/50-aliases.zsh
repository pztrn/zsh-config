# Some great default aliases.
# Custom aliases should go to ${HOME}/.zsh-config.d/10-aliases.conf
# (or other file).
alias screen="TERM=xterm screen"

# Other
alias clocksync="sudo ntpdate 0.pool.ntp.org"
alias got="git"

for item in `find "${CONFIG_PATH}/zsh/aliases" -type f -exec basename {} \; | sort`; do
    source "${CONFIG_PATH}/zsh/aliases/${item}"
done

if [ -d "${HOME}/.zsh-config.d/aliases" ]; then
    for item in `find "${HOME}/.zsh-config.d/aliases" -type f -exec basename {} \; | sort`; do
        if [ -f "${HOME}/.zsh-config.d/aliases/${item}" ]; then
            source "${HOME}/.zsh-config.d/aliases/${item}"
        fi
    done
fi
