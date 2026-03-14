color1="\033[1;31m"
color2="\033[1;32m"
color3="\033[1;34m"
color4="\033[1;33m"
color5="\033[1;35m"
defaultColor="\033[0m"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

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

printCat "$color3" "And I will install some useful packages"
# Install yay
echo "Installing yay package manager"
sudo pacman -S --needed base-devel --noconfirm
git clone https://aur.archlinux.org/yay.git ~/yay
cd ~/yay
makepkg -si
cd $script_dir
# Install p10k
printCat "$color3" "I will install powerlevel10k"
yay -S --noconfirm zsh-theme-powerlevel10k-git zen-browser-bin
# Install packages

if [ "$WITH_GUI_INSTALL" = true ]; then
  sudo pacman -S --noconfirm stow zip unzip npm python3 less kitty ghostty firefox telegram-desktop zathura yazi bat eza fd fzf gcc rustup go fastfetch neovim wireguard-tools ripgrep thefuck tldr tmux tor wget zellij zoxide sl
else
  sudo pacman -S --noconfirm stow zip unzip npm python3 less yazi bat eza fd fzf gcc rustup go fastfetch neovim wireguard-tools ripgrep thefuck tldr tmux tor wget zellij zoxide sl
fi
# Install Rust utils
rustup default stable
echo -e "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

# Install JetBrains Mono Nerd font
printCat "$color3" "Nerd font is required. I will install the best for you."
yay -S --noconfirm ttf-jetbrains-mono-nerd ttf-jetbrains-mono
echo ""
