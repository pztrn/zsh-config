bindkey -e
zstyle :compinstall filename '${CONFIG_PATH}/.zshrc'

setopt completealiases
setopt correct
setopt interactivecomments
# This should help with WSL.
setopt TYPESET_SILENT