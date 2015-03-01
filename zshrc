#!/bin/bash
# ^^^ THIS IS FOR SYNTAX HIGHLIGHT!

#. /etc/profile

#####################################################################
# CONFIGURATION
# -------------
# You should set these variables :)
#####################################################################
# The very important thing - debug.
# Should we enable debug output?
DEBUG=0
# Prompt configuration
PROMPT_THEME="pztrn"

# FBTerm - should we use it?
# nVidia users with proprietary drivers - sorry, you can't use it.
USE_FBTERM=0

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
    for config_file in `ls ${CONFIG_PATH}/zsh/ | sort | grep zsh`; do
        source ${CONFIG_PATH}/zsh/${config_file}
    done
else
    echo "Failed to load configuration."
fi

set -B


