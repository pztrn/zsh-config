# This configuration was completely stolen from Oh-My-ZSH:
# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/key-bindings.zsh
# Enchanced with more word actions (move backward and forward one word), I
# prefer ALT key to do same thing.

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init() {
        echoti smkx
    }
    function zle-line-finish() {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Bash-like backward delete.
autoload -U select-word-style
select-word-style bash

case "${TERM}" in
    cons25*|linux) # plain BSD/Linux console
        bindkey '\e[H'    beginning-of-line   # home
        bindkey '\e[F'    end-of-line         # end
        bindkey '\e[5~'   delete-char         # delete
        bindkey '[D'      emacs-backward-word # esc left
        bindkey '[C'      emacs-forward-word  # esc right
    ;;
    *rxvt*) # rxvt derivatives
        bindkey '\e[3~'     delete-char         # delete
        bindkey '\eOc'      forward-word        # ctrl right
        bindkey '\eOd'      backward-word       # ctrl left
        bindkey '\e\e[D'   backward-word ### Alt left
        bindkey '\e\e[C'  forward-word ### Alt right
        # workaround for screen + urxvt
        bindkey '\e[7~'   beginning-of-line   # home
        bindkey '\e[8~'   end-of-line         # end
        bindkey '^[[1~'   beginning-of-line   # home
        bindkey '^[[4~'   end-of-line         # end
    ;;
    *xterm*) # xterm derivatives
        bindkey '\e[H'    beginning-of-line   # home
        bindkey '\e[F'    end-of-line         # end
        bindkey '\e[3~'   delete-char         # delete
        bindkey '\e[1;5C' forward-word        # ctrl right
        bindkey '\e[1;5D' backward-word       # ctrl left
        # workaround for screen + xterm
        bindkey '\e[1~'   beginning-of-line   # home
        bindkey '\e[4~'   end-of-line         # end
    ;;
    screen)
        bindkey '^[[1~'   beginning-of-line   # home
        bindkey '^[[4~'   end-of-line         # end
        bindkey '\e[3~'   delete-char         # delete
        bindkey '\eOc'    forward-word        # ctrl right
        bindkey '\eOd'    backward-word       # ctrl left
        bindkey '^[[1;5C' forward-word        # ctrl right
        bindkey '^[[1;5D' backward-word       # ctrl left
    ;;
esac
