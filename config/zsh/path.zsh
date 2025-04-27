# PATH Configuration

# Homebrew path
if [[ "$(uname -m)" == "arm64" ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  export HOMEBREW_PREFIX="/usr/local"
fi

export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"

# n (Node.js version manager) setup
export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

# Add any additional paths below

