# Gregory's Dotfiles

My personal dotfiles for macOS development environment setup. This repository contains configuration files for ZSH, Git, and various command-line tools to enhance productivity and ensure consistent setups across machines.

## Features

- **Modern ZSH Configuration**: Modular structure with Oh My Zsh and Powerlevel10k theme
- **Easy Installation**: Minimal effort to install everything using GNU Stow and Makefile
- **Package Management**: Homebrew with Brewfile for consistent software installation
- **macOS Optimizations**: Custom settings and productivity enhancements
- **Well-organized and Modular**: Easy to understand, maintain, and customize
- **Supports Apple Silicon and Intel Macs**: Tested on various macOS versions

## Directory Structure

```
~/.dotfiles/
├── bin/                   # Custom scripts and executables
├── config/                # Configuration files symlinked to ~/.config
│   ├── git/               # Git configuration
│   ├── tmux/              # Tmux configuration
│   ├── zsh/               # Modular ZSH configuration
│   │   ├── aliases.zsh    # Command aliases
│   │   ├── completions.zsh # Tab completion settings
│   │   ├── exports.zsh    # Environment variables
│   │   ├── functions.zsh  # Shell functions
│   │   ├── keybindings.zsh # Custom key bindings
│   │   ├── oh-my-zsh.zsh  # Oh My Zsh settings
│   │   ├── path.zsh       # PATH modifications
│   │   ├── private.zsh    # Private/sensitive settings (gitignored)
│   │   └── utils.zsh      # Utility functions
│   └── ...
├── install/               # Installation scripts
│   └── oh-my-zsh.sh       # Oh My Zsh and plugins installer
├── macos/                 # macOS-specific settings and scripts
├── runcom/                # Run commands, like .zshrc, .bashrc
│   └── .zshrc             # Main ZSH configuration file
├── system/                # System configuration
├── Brewfile               # Homebrew packages
├── Makefile               # Installation automation
└── README.md              # This file
```

## Installation

### On a fresh macOS installation:

1. Install Apple's Command Line Tools:

```bash
xcode-select --install
```

2. Clone this repository:

```bash
git clone https://github.com/gastevens/.dotfiles.git ~/.dotfiles
```

3. Install Homebrew (if not already installed):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

4. Install GNU Stow:

```bash
brew install stow
```

5. Use Stow to create symlinks:

```bash
cd ~/.dotfiles
stow -t ~ runcom
stow -t ~/.config config
```

6. Install Oh My Zsh and plugins:

```bash
chmod +x ~/.dotfiles/install/oh-my-zsh.sh
~/.dotfiles/install/oh-my-zsh.sh
```

7. Install packages using Homebrew:

```bash
brew bundle --file=~/.dotfiles/Brewfile
```

## ZSH Configuration

The ZSH configuration is organized into modular files in `~/.dotfiles/config/zsh/`:

- **aliases.zsh**: Command shortcuts and aliases
- **completions.zsh**: Tab completion settings and customizations
- **exports.zsh**: Environment variables 
- **functions.zsh**: Custom shell functions
- **keybindings.zsh**: Custom key bindings for enhanced navigation
- **oh-my-zsh.zsh**: Oh My Zsh specific settings
- **path.zsh**: PATH environment variable modifications
- **private.zsh**: Private environment variables (gitignored)
- **utils.zsh**: Utility functions and brew-wrap

### Included Oh My Zsh Plugins

- git: Git integration and shortcuts
- macos: macOS-specific commands and aliases
- docker: Docker commands and completion
- npm: npm commands and completion
- zoxide: Smarter cd command (replaces autojump)
- thefuck: Corrects your previous console command
- zsh-autosuggestions: Fish-like autosuggestions
- zsh-syntax-highlighting: Syntax highlighting for commands
- web-search: Quick web searches from terminal
- And more...

## Post-Installation

1. Set your Git credentials:

```sh
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global github.user "your-github-username"
```

2. Set macOS system defaults:

```sh
dot macos
```

3. Configure Powerlevel10k theme (if not already configured):

```sh
p10k configure
```

4. Add private environment variables:

```sh
nano ~/.dotfiles/config/zsh/private.zsh
```

## The `dot` Command

The `dot` command provides easy access to common dotfiles maintenance tasks:

```
$ dot help
Usage: dot <command>

Commands:
   clean            Clean up caches (brew, cargo, gem, pip)
   dock             Apply macOS Dock settings
   duti             Set default apps for file types (UTI)
   edit             Open dotfiles in IDE (code) and Git GUI
   help             This help message
   macos            Apply macOS system defaults
   test             Run tests
   update           Update packages and pkg managers (brew, casks, cargo, pip3, npm, gems, macOS)
```

## Customization

To customize these dotfiles to your preferences:

1. **Adding aliases**: Edit `~/.dotfiles/config/zsh/aliases.zsh`
2. **Adding functions**: Edit `~/.dotfiles/config/zsh/functions.zsh` or `~/.dotfiles/config/zsh/utils.zsh`
3. **Changing PATH**: Edit `~/.dotfiles/config/zsh/path.zsh`
4. **Private settings**: Add sensitive information to `~/.dotfiles/config/zsh/private.zsh`
5. **Adding Oh My Zsh plugins**: Edit the `plugins=()` list in `~/.dotfiles/runcom/.zshrc`

## Maintenance

### Keeping dotfiles in sync across machines:

```bash
# Pull latest changes
cd ~/.dotfiles
git pull

# Push your changes
cd ~/.dotfiles
git add -u
git commit -m "description of changes"
git push
```

### Adding new tools:

1. Install via Homebrew: `brew install tool-name`
2. Add to Brewfile: `brew bundle dump --force --file=~/.dotfiles/Brewfile`

## Package Management

This dotfiles repository uses a comprehensive Brewfile to manage:

1. Command-line utilities and development tools (via Homebrew)
2. GUI applications (via Homebrew Casks)
3. Mac App Store applications (via mas-cli)
4. VS Code extensions

### Common Commands

```bash
# Install all packages from Brewfile
brew bundle --file=~/.dotfiles/Brewfile

# Update all package managers
dot update-packages  # Uses custom script
# OR manually:
brew update && brew upgrade && mas upgrade

# Check for outdated packages
brew outdated
mas outdated

# Add new packages to Brewfile after installing
brew bundle dump --force --file=~/.dotfiles/Brewfile

# Clean up old packages
brew cleanup
```

### Verification

To verify your setup on a new machine or after major changes:

```bash
dot verify-setup
```

This checks that:

1. All required tools are installed
2. Symlinks are properly configured
3. Configuration files are properly loaded
4. Package managers are working correctly

### Best Practices

1. Always use Homebrew or mas to install software when available
2. Keep your Brewfile in version control to ensure consistent environments
3. Run `dot update-packages` regularly to keep everything up to date
4. After installing new software, update your Brewfile with `brew bundle dump --force --file=~/.dotfiles/Brewfile`
5. Review Brewfile changes before committing to ensure only desired packages are included

## Credits

- Inspired by the [dotfiles community](https://dotfiles.github.io)
- Oh My Zsh: [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- Powerlevel10k: [romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)
