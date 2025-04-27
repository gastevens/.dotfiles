# Environment Variables and Exports

# Default editors
export EDITOR="nano"
export VISUAL="code"

# Language
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# History settings
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# Colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Keep this file for your private environment variables
# (API keys, tokens, etc.) - it's included in .gitignore
[ -f "$DOTFILES/config/zsh/private.zsh" ] && source "$DOTFILES/config/zsh/private.zsh"

