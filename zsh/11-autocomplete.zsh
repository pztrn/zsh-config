# Mac related - ensure that homebrew path on arm64 is added to fpath,
# otherwise autocompletions from installed packages won't work.
if [ "${OS}" = "Darwin" ] && [ "${OS_ARCH}" = "arm64" ]; then
	export fpath=(${fpath} /opt/homebrew/share/zsh/site-functions)
fi

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
