# Oh My Zsh Configuration

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 14   # check for updates every 14 days

# History settings
HIST_STAMPS="yyyy-mm-dd"           # Date format for history
setopt HIST_IGNORE_ALL_DUPS        # Don't record duplicates in history
setopt HIST_FIND_NO_DUPS           # Don't display duplicates when searching
setopt HIST_REDUCE_BLANKS          # Remove unnecessary blanks
setopt INC_APPEND_HISTORY          # Add commands to history as they're typed
setopt EXTENDED_HISTORY            # Record timing info

# ZSH specific settings
setopt AUTO_CD                      # Type directory name to cd into it
setopt COMPLETE_ALIASES             # Complete aliases
setopt INTERACTIVE_COMMENTS         # Allow comments in interactive shell

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# HIST_STAMPS="mm/dd/yyyy"

