#!/bin/bash
# ^^^ THIS IS FOR SYNTAX HIGHLIGHT!

#. /etc/profile

#####################################################################
# INITIALIZATION
# --------------
# Here goes initialization thing.
# DO NOT CHANGE ANYTHING, UNLESS YOU ARE KNOW WHAT ARE YOU DOING!
#####################################################################
# Get real script path.
CONFIG_PATH=''
CONFIG_FOUND=0

if [ -h ${HOME}/.zshrc ]; then
    CONFIG_PATH=`readlink ${HOME}/.zshrc`
    CONFIG_PATH=`dirname ${CONFIG_PATH}`
    if [ ${#CONFIG_PATH[@]} -gt 0 ]; then
        CONFIG_FOUND=1
    else
        echo "CONFIG_PATH has invalid value: '${CONFIG_PATH}'"
    fi
fi

# Some sourcing.
source ${CONFIG_PATH}/zsh/lib/logger.lib.sh

if [ $CONFIG_FOUND -eq 1 ]; then
    for config_file in `ls --color=never ${CONFIG_PATH}/zsh/ | sort | grep zsh`; do
        source ${CONFIG_PATH}/zsh/${config_file}
    done
else
    error "Failed to load configuration."
fi

set -B
