color1="\033[1;31m"
color2="\033[1;32m"
color3="\033[1;34m"
color4="\033[1;33m"
color5="\033[1;35m"
defaultColor="\033[0m"

printCat() {
  local color="$1"
  local message="${2:-Meow}"

  echo -e "             ${color}${message}"
  echo -e "             ${color}/"
  echo -e "         ${color}/^•˕•^\\ ${defaultColor}"
}

# Install zsh
printCat "$color3" "Let's change your default shell to zsh"
sudo pacman -S zsh --noconfirm
chsh -s /bin/zsh
echo -e "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

# Install packages
printCat "$color3" "And I will install some useful packages"
sudo pacman -S --noconfirm ghostty kitty zen-browser telegram-desktop zathura yazi bat eza fd fzf gcc rustup go fastfetch neovim obfs4proxy wireguard-tools openssl@3 ripgrep thefuck tldr tmux tor wget zellij zoxide powerlevel10k sl
echo -e "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

# Install JetBrains Mono Nerd font
printCat "$color3" "Nerd font is required. I will install the best for you."
mkdir -p /usr/share/fonts/TTF
cp -r fonts/* /usr/share/fonts/TTF
echo ""
