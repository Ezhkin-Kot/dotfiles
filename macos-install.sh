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
  echo "         ${color}/ᐠoꞈoᐟ\\ ${defaultColor}"
}

# Install Homebrew and add it to the PATH
printCat "$color3" "Let's install the package manager"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
echo "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

# Install packages
printCat "$color3" "And I will install some useful packages"
brew install --cask ghostty
brew install bat yazi eza fd fzf gcc neovim obfs4proxy wireguard-tools openssl@3 ripgrep thefuck tldr tmux tor wget zellij zoxide powerlevel10k sl
echo "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

# Install JetBrains Mono Nerd font
printCat "$color3" "Nerd font is required. I will install the best for you."
cp -r fonts/* ~/Library/Fonts
echo ""
