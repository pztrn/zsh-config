# Logger for debug output.

# Debug messages array.
DEBUG_MESSAGES=("\033[1;32mINFO     \033[1;m" "\033[1;36mDEBUG    \033[1;m" "\033[1;31mHARDDEBUG\033[1;m")

# Colorize messages depending on verbosity level.
VERB_LVL_COLORS=("\033[1;m" "\033[1;34m" "\033[1;35m")

# Formatted message will be placed in this variable.
FORMATTED_MESSAGE=""

function log() {
    # Just log.
    log_common $1 "$2"
    if [ $? -eq 0 ]; then
        echo -e "${VERB_LVL_COLORS[${1}]}${FORMATTED_MESSAGE}\033[1;m"
    fi
}

function log_common() {
    # Executes some common things for logs.
    local DEBUG_LVL=$1
    local MESSAGE=$2

    check_debug ${DEBUG_LVL}
    if [ $? -ne 0 ]; then
        return 1
    fi

    # All ok, printing...
    FORMATTED_MESSAGE="[${DEBUG_MESSAGES[${DEBUG_LVL}]}] ${MESSAGE}"
    return 0
}

function error() {
    # Just log.
    error_common $1 "$2"
    if [ $? -eq 0 ]; then
        echo -e "${VERB_LVL_COLORS[${1}]}${FORMATTED_MESSAGE}\033[1;m"
    fi
}

function error_common() {
    # Executes some common things for logs.
    local DEBUG_LVL=$1
    local MESSAGE=$2

    check_debug ${DEBUG_LVL}
    if [ $? -ne 0 ]; then
        return 1
    fi

    # All ok, printing...
    FORMATTED_MESSAGE="[ERROR] \033[1;31m${MESSAGE}\033[1;m"
    return 0
}


function check_debug() {
    # Checks for debug level and if it applicable to us.
    # Return codes:
    #   - 0: this debug level is okay to be printed.
    #   - 1: this debug level should not be printed.
    local DEBUG_LVL=$1


    if [ ${DEBUG_LVL} -le ${DEBUG} ]; then
        return 0
    else
        return 1
    fi
}
