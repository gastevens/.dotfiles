# Dotfiles ZSH Configuration
# symlinked to ~/.zshrc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to dotfiles
export DOTFILES="$HOME/.dotfiles"

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set ZSH theme - Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh My Zsh plugins
plugins=(
  git
  macos
  docker
  brew
  npm
  zoxide
  history
  thefuck
  dotenv
  zsh-autosuggestions
  zsh-syntax-highlighting
  web-search
  copypath
  copyfile
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration
# ====================

# Load all dotfiles configurations
for file in $DOTFILES/config/zsh/*.zsh; do
  source "$file"
done

# Brew wrap if available
if [ -f $(brew --prefix)/etc/brew-wrap ]; then
  source $(brew --prefix)/etc/brew-wrap
fi

# PATH configurations
# Add dotfiles bin to PATH
export PATH="$DOTFILES/bin:$PATH"

# Add local bin to PATH (for pipx etc.)
export PATH="$PATH:$HOME/.local/bin"

# Source Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

