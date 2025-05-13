# ZSH Config by Ezhkin-Kot

It's my own ZSH configuration for MacOS and the script for automatic installation of all these configurations, tools and dotfiles in your system. It was created for quickly setting up the system with one command. You should change some paths in .zshrc according to your system user name. 

## Installation

### 1. Clone the repository

```sh
git clone https://github.com/Ezhkin-Kot/zsh-config.git
cd zsh-config
```

### 2. Run the install script
```sh
chmod +x ./install.sh
./install.sh
```

The script will:
- Install Homebrew if it’s not already installed
- Install iTerm2 terminal emulator
- Install useful CLI tools and plugins
- Set up oh-my-zsh, powerlevel10k, and custom configurations
- Configure git global environments from user's data
- Install Nerd Fonts for terminal icons

### 3. Set up fonts

Set up JetBrains Mono Nerd font in iTerm preferences.

### 4. Restart your ZSH

After the installation is completed and the terminal opens, restart your shell with command:
```sh
source ~/.zshrc
```

## Installed Packages
- iTerm - a full featured terminal emulation program for MacOS.
- `oh-my-zsh` – framework for managing Zsh configuration.
- `zsh-autosuggestions` – suggests commands as you type, based on your history.
-	`zsh-syntax-highlighting` – adds syntax highlighting to your Zsh command line.
- `powerlevel10k` – a beautiful zsh theme configurator.
- `bat` – a `cat` clone with syntax highlighting and Git integration.
- `eza` – a modern replacement for `ls` with more features and better formatting.
- `fd` – a simple, fast alternative to `find`.
- `fzf` – a general-purpose command-line fuzzy finder.
- `gcc` – the GNU Compiler Collection for compiling C/C++ and other languages.
- `neovim` – a modernized and more extensible version of Vim.
- `obfs4proxy` – a pluggable transport proxy for Tor.
- `openssl` – toolkit for TLS/SSL and cryptographic functions.
- `ripgrep` – a fast search tool like `grep`, optimized for large codebases.
- `thefuck` – corrects errors in previous console commands.
- `tldr` – simplified and community-driven man pages.
- `tmux` – a terminal multiplexer that lets you switch between sessions in one terminal window.
- `tor` – a tool for anonymous communication over the internet.
- `wget` – a command-line utility for downloading files from the web.
- `zellij` – a terminal workspace and multiplexer, alternative to `tmux`, but does not require configuration.
- `zoxide` – a smarter `cd` command that remembers your most-used directories.

Fonts
- JetBrains Mono Nerd Font (included in fonts/)

## NeoVim

After all you also can install my NeoVim config:
https://github.com/Ezhkin-Kot/nvim

## Troubleshooting

If this zshrc config works incorrectly, you can restore your old config from `.zshrc-backup` using the following command:
```sh
cp ~/.zshrc-backup ~/.zshrc
```
