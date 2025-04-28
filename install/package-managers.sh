#!/usr/bin/env bash

# package-managers.sh
# This script installs and configures various package managers

# ===== Colors and formatting =====
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ===== Directories =====
DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# ===== Functions =====

# Print section headers
print_header() {
    echo -e "\n${BLUE}${BOLD}===== $1 =====${NC}\n"
}

# Check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Success message
success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Error message
error() {
    echo -e "${RED}✗ $1${NC}"
}

# Warning message
warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Create backup of a file
backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        cp "$file" "$BACKUP_DIR/$(basename "$file").bak"
        success "Backed up $file to $BACKUP_DIR/$(basename "$file").bak"
    fi
}

# Check if brew is installed
check_brew() {
    if ! command_exists brew; then
        error "Homebrew is not installed. Please install Homebrew first."
        echo "Visit https://brew.sh for installation instructions."
        exit 1
    fi
    success "Homebrew is installed"
}

# ===== Installation and Configuration =====

print_header "Package Managers Installation"

# Check for brew
check_brew

# Make sure Brewfile has been processed
print_header "Checking for required packages"
if brew list asdf mise volta pyenv deno &>/dev/null; then
    success "All required packages are installed"
else
    warning "Some required packages may not be installed"
    echo -e "Running ${BOLD}brew bundle${NC} to install required packages..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

# Configure ASDF
print_header "Configuring ASDF"
if command_exists asdf; then
    # Backup existing configuration
    backup_file "$HOME/.asdfrc"
    backup_file "$HOME/.tool-versions"
    
    # Create .asdfrc if it doesn't exist
    if [ ! -f "$HOME/.asdfrc" ]; then
        echo "legacy_version_file = yes" > "$HOME/.asdfrc"
        success "Created .asdfrc with legacy version file support"
    fi
    
    # Create .tool-versions if it doesn't exist
    if [ ! -f "$HOME/.tool-versions" ]; then
        cat > "$HOME/.tool-versions" << EOF
nodejs 20.12.2
python 3.13.0
ruby 3.3.1
golang 1.22.3
EOF
        success "Created .tool-versions with common language versions"
    fi
    
    # Add plugins
    echo "Adding ASDF plugins..."
    asdf plugin add nodejs || true
    asdf plugin add python || true
    asdf plugin add ruby || true
    asdf plugin add golang || true
    
    # Install versions from .tool-versions
    echo "Installing language versions from .tool-versions..."
    asdf install
    
    success "ASDF configuration complete"
else
    error "ASDF is not installed. Skipping configuration."
fi

# Configure Mise (modern alternative to ASDF)
print_header "Configuring Mise"
if command_exists mise; then
    # Backup existing configuration
    backup_file "$HOME/.config/mise/config.toml"
    
    # Create mise config directory
    mkdir -p "$HOME/.config/mise"
    
    # Create config.toml
    cat > "$HOME/.config/mise"'config.toml' << EOF
[settings]
always_keep_download = true
experimental = false
jobs = 4
not_found_auto_install = true
trusted_repos = []

[tools]
node = "20"
python = "3.13"
go = "latest"
EOF
    
    success "Mise configuration complete"
else
    error "Mise is not installed. Skipping configuration."
fi

# Configure Volta (JavaScript tool manager)
print_header "Configuring Volta"
if command_exists volta; then
    # Add Volta to path if not already in path
    if ! grep -q "VOLTA_HOME" "$HOME/.zshrc"; then
        backup_file "$HOME/.zshrc"
        
        echo '# Volta - JavaScript tool manager' >> "$HOME/.zshrc"
        echo 'export VOLTA_HOME="$HOME/.volta"' >> "$HOME/.zshrc"
        echo 'export PATH="$VOLTA_HOME/bin:$PATH"' >> "$HOME/.zshrc"
        
        success "Added Volta to PATH in .zshrc"
    fi
    
    # Install Node.js LTS
    volta install node@lts
    
    # Install some useful global packages
    echo "Installing useful global Node.js packages..."
    volta install npm@latest yarn@latest pnpm@latest typescript@latest
    
    success "Volta configuration complete"
else
    error "Volta is not installed. Skipping configuration."
fi

# Configure Pyenv (Python version manager)
print_header "Configuring Pyenv"
if command_exists pyenv; then
    # Add pyenv to path if not already in path
    if ! grep -q "pyenv init" "$HOME/.zshrc"; then
        backup_file "$HOME/.zshrc"
        
        echo '# Pyenv - Python version manager' >> "$HOME/.zshrc"
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> "$HOME/.zshrc"
        echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> "$HOME/.zshrc"
        echo 'eval "$(pyenv init -)"' >> "$HOME/.zshrc"
        
        success "Added Pyenv to PATH in .zshrc"
    fi
    
    # Install latest Python versions
    echo "Installing Python versions..."
    pyenv install 3.13.0 --skip-existing
    pyenv install 3.10.14 --skip-existing
    
    # Set global Python version
    pyenv global 3.13.0
    
    success "Pyenv configuration complete"
else
    error "Pyenv is not installed. Skipping configuration."
fi

# Configure Deno (JavaScript/TypeScript runtime)
print_header "Configuring Deno"
if command_exists deno; then
    # Create deno configuration directory
    mkdir -p "$HOME/.deno"
    
    # Add deno to path if not already in path
    if ! grep -q "DENO_INSTALL" "$HOME/.zshrc"; then
        backup_file "$HOME/.zshrc"
        
        echo '# Deno - JavaScript/TypeScript runtime' >> "$HOME/.zshrc"
        echo 'export DENO_INSTALL="$HOME/.deno"' >> "$HOME/.zshrc"
        echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> "$HOME/.zshrc"
        
        success "Added Deno to PATH in .zshrc"
    fi
    
    success "Deno configuration complete"
else
    error "Deno is not installed. Skipping configuration."
fi

print_header "Summary"
echo -e "Package managers installation and configuration ${GREEN}complete${NC}!"
echo -e "Backup files created in: ${BOLD}$BACKUP_DIR${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Restart your terminal or run 'source ~/.zshrc'"
echo "2. Run appropriate language-specific commands to verify installation:"
echo "   - Node.js: node --version"
echo "   - Python: python --version"
echo "   - Ruby: ruby --version"
echo "   - Go: go version"
echo "   - Deno: deno --version"
echo ""
echo -e "${BOLD}Note:${NC} To update language versions in the future, edit ~/.tool-versions"

