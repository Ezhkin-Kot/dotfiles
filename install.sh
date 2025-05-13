color1="\033[1;31m"
color2="\033[1;32m"
color3="\033[1;34m"
color4="\033[1;33m"
color5="\033[1;35m"
defaultColor="\033[0m"

printCat() {
  local color="$1"
  local message="${2:-Meow}"

  echo "             ${color}${message}"
  echo "             ${color}/"
  echo "         ${color}/ᐠ｡ꞈ｡ᐟ\\ ${defaultColor}"
}

if [ "$EUID" -eq 0 ]; then
  printCat "$color4" "Please do not run this script as root. Run it as a normal user."
  exit 1
fi

echo ""
echo "Oh, what a boring terminal you have! Don't worry, now we will fix it."
echo ""
echo "             ${color1}Meow            ${color2}Meow            ${color3}Meow"
echo "             ${color1}/               ${color2}/               ${color3}/"
echo "         ${color1}/ᐠ｡ꞈ｡ᐟ\\         ${color2}/ᐠ｡ꞈ｡ᐟ\\         ${color3}/ᐠ｡ꞈ｡ᐟ\\ ${defaultColor}"
echo "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

printCat "$color2" "Please, give me your sudo password"
sudo -v

# Install Homebrew and add it to the PATH
printCat "$color3" "Let's install package manager"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
echo "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

# Install oh-my-zsh
printCat "$color1" "Now I will install zsh plugin manager"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
echo "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

# Install packages
printCat "$color3" "And I will install some useful packages"
brew install --cask iterm2
brew install bat eza fd fzf gcc neovim obfs4proxy openssl@3 ripgrep thefuck tldr tmux tor wget zellij zoxide powerlevel10k
echo "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

# Rewrite configs
printCat "$color1" "I need to change your .zshrc config. This may request your password again."
cp .zshrc ~/.zshrc
echo "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

printCat "$color1" "And some other configs"
mkdir -p ~/.config
cp -r bat ~/.config/bat
cp -r .fzf-git.sh ~/.fzf-git.sh
echo "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

# Configure Git
printCat "$color1" "Now let's configure Git for your global environment" 
read -p "Enter your Git user name: " git_username
read -p "Enter your Git email: " git_email

git config --global user.name "$git_username"
git config --global user.email "$git_email"
git config --global core.editor "nvim"
git config --global color.ui "auto"

echo ""
echo "${color2} Git has been configured successfully!"
echo "Current Git config:"
git config --global --list

# Install JetBrains Mono Nerd font
printCat "$color3" "Nerd font is required for this config. I will install the best for you."
cp -r fonts/* ~/Library/Fonts
echo "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

printCat "$color2" "Congratulations! Now your terminal has become excellent!"
source ~/.zshrc
open /Applications/iTerm.app
