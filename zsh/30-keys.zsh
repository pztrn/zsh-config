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

bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
if [[ "${terminfo[kpp]}" != "" ]]; then
  bindkey "${terminfo[kpp]}" up-line-or-history       # [PageUp] - Up a line of history
fi
if [[ "${terminfo[knp]}" != "" ]]; then
  bindkey "${terminfo[knp]}" down-line-or-history     # [PageDown] - Down a line of history
fi

if [[ "${terminfo[kcuu1]}" != "" ]]; then
  bindkey "${terminfo[kcuu1]}" up-line-or-search      # start typing + [Up-Arrow] - fuzzy find history forward
fi
if [[ "${terminfo[kcud1]}" != "" ]]; then
  bindkey "${terminfo[kcud1]}" down-line-or-search    # start typing + [Down-Arrow] - fuzzy find history backward
fi

if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
fi

bindkey ' ' magic-space                               # [Space] - do history expansion

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

case "${TERM}" in
    cons25*|linux) # plain BSD/Linux console
        bindkey '\e[H'    beginning-of-line   # home
        bindkey '\e[F'    end-of-line         # end
        bindkey '\e[5~'   delete-char         # delete
        bindkey '[D'      emacs-backward-word # esc left
        bindkey '[C'      emacs-forward-word  # esc right
    ;;
    *rxvt*) # rxvt derivatives
        bindkey '\eOc'    forward-word        # ctrl right
        bindkey '\eOd'    backward-word       # ctrl left
        bindkey '\e\e[D'  backward-word     ### Alt left
        bindkey '\e\e[C'  forward-word      ### Alt right

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
        bindkey '^[[C'    forward-word        # ctrl right
        bindkey '^[[D'    backward-word       # ctrl left
        bindkey '\eOC'    forward-word        # ctrl right
        bindkey '\eOD'    backward-word       # ctrl left
        bindkey '^[[1;3C' forward-word        # alt right
        bindkey '^[[1;3D' backward-word       # alt left
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
