#!/usr/bin/env bash

# tool-configs.sh
# This script configures the newly installed command-line tools

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

# Append text to a file if it doesn't already contain it
append_to_file() {
    local file="$1"
    local text="$2"
    if [ ! -f "$file" ] || ! grep -q "$text" "$file"; then
        echo "$text" >> "$file"
        success "Updated $file"
    else
        warning "$file already contains the desired text"
    fi
}

# Create directory if it doesn't exist
ensure_dir() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        success "Created directory $dir"
    fi
}

# ===== Tool Configurations =====

print_header "Configuring Command-Line Tools"

# Check if required tools are installed
missing_tools=()
for tool in starship eza btop lazygit fd fzf bat zoxide; do
    if ! command_exists "$tool"; then
        missing_tools+=("$tool")
    fi
done

if [ ${#missing_tools[@]} -gt 0 ]; then
    warning "Some tools are not installed: ${missing_tools[*]}"
    echo -e "Installing missing tools using ${BOLD}brew bundle${NC}..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

# Configure Starship prompt
print_header "Configuring Starship Prompt"

if command_exists starship; then
    ensure_dir "$CONFIG_DIR"
    backup_file "$CONFIG_DIR/starship.toml"
    
    cat > "$CONFIG_DIR/starship.toml" << 'EOF'
# Get editor completions based on the config schema
"$schema" = 'https://starship.rs/config-schema.json'

# Don't print a new line at the start of the prompt
add_newline = true

# Replace the '❯' symbol with '➜'
[character]
success_symbol = '[➜](bold green)'
error_symbol = '[✗](bold red)'

# Use custom format
format = """
[](#9A348E)\
$os\
$username\
[](bg:#DA627D fg:#9A348E)\
$directory\
[](fg:#DA627D bg:#FCA17D)\
$git_branch\
$git_status\
[](fg:#FCA17D bg:#86BBD8)\
$c\
$elixir\
$elm\
$golang\
$haskell\
$java\
$julia\
$nodejs\
$nim\
$python\
$rust\
$scala\
[](fg:#86BBD8 bg:#06969A)\
$docker_context\
[](fg:#06969A bg:#33658A)\
$time\
[ ](fg:#33658A)\
$fill\
$cmd_duration $jobs $battery
$line_break
$character"""

# Custom palette
palette = "catppuccin_mocha"

[fill]
symbol = " "

[palettes.catppuccin_mocha]
rosewater = "#f5e0dc"
flamingo = "#f2cdcd"
pink = "#f5c2e7"
mauve = "#cba6f7"
red = "#f38ba8"
maroon = "#eba0ac"
peach = "#fab387"
yellow = "#f9e2af"
green = "#a6e3a1"
teal = "#94e2d5"
sky = "#89dceb"
sapphire = "#74c7ec"
blue = "#89b4fa"
lavender = "#b4befe"
text = "#cdd6f4"
subtext1 = "#bac2de"
subtext0 = "#a6adc8"
overlay2 = "#9399b2"
overlay1 = "#7f849c"
overlay0 = "#6c7086"
surface2 = "#585b70"
surface1 = "#45475a"
surface0 = "#313244"
base = "#1e1e2e"
mantle = "#181825"
crust = "#11111b"

# Display time
[time]
disabled = false
format = '[$time]($style)'
time_format = '%R'
style = 'bg:#33658A'

# Display username
[username]
style_user = 'white bold bg:#9A348E'
style_root = 'black bold bg:#9A348E'
format = '[$user ]($style)'
disabled = false
show_always = true

# Display current directory
[directory]
style = 'white bold bg:#DA627D'
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

# Shows the battery level
[battery]
full_symbol = "🔋 "
charging_symbol = "

