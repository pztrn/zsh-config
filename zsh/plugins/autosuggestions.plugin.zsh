AUTOSUGGESTIONS_PATH=""

if [ "${DISTRO}" = "Arch" ]; then AUTOSUGGESTIONS_PATH="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"; fi
if [ "${DISTRO}" = "Debian" ]; then AUTOSUGGESTIONS_PATH="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"; fi
if [ "${DISTRO}" = "Darwin" ]; then AUTOSUGGESTIONS_PATH="/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"; fi
if [ "${DISTRO}" = "Ubuntu" ]; then AUTOSUGGESTIONS_PATH="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"; fi
if [ "${DISTRO}" = "VoidLinux" ]; then AUTOSUGGESTIONS_PATH="/usr/share/zsh/plugins/zsh-autosuggestions.zsh"; fi

if [ -f "${AUTOSUGGESTIONS_PATH}" ]; then
  source "${AUTOSUGGESTIONS_PATH}"
  export PLUGIN_ZSH_AUTOSUGGESTIONS_LOADED=1
else
  echo "Autosuggestions plugin enabled but not installed. Please install zsh-autosuggestions as per https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md"
fi
