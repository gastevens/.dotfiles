# ZSH Key Bindings

# Use emacs key bindings
bindkey -e

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word

# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word

# [Delete] - delete forward
bindkey -M emacs '^[[3~' delete-char
bindkey -M viins '^[[3~' delete-char
bindkey -M vicmd '^[[3~' delete-char

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char

# [Ctrl-a] - Beginning of line
bindkey -M emacs '^a' beginning-of-line
bindkey -M viins '^a' beginning-of-line

# [Ctrl-e] - End of line
bindkey -M emacs '^e' end-of-line
bindkey -M viins '^e' end-of-line

# [Ctrl-k] - Delete from cursor to end of line
bindkey -M emacs '^k' kill-line
bindkey -M viins '^k' kill-line

# [Ctrl-u] - Delete from beginning of line to cursor
bindkey -M emacs '^u' backward-kill-line
bindkey -M viins '^u' backward-kill-line

# [Alt-Left] - Word back
bindkey '^[^[[D' backward-word

# [Alt-Right] - Word forward
bindkey '^[^[[C' forward-word

