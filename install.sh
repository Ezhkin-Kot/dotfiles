color1="\033[1;31m"
color2="\033[1;32m"
color3="\033[1;34m"
color4="\033[1;33m"
color5="\033[1;35m"
defaultColor="\033[0m"

cpEcho() { # cross-platform echo
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "$1"
  else
    echo -e "$1"
  fi
}

printCat() {
  local color="$1"
  local message="${2:-Meow}"

  cpEcho "             ${color}${message}"
  cpEcho "             ${color}/"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "         ${color}/ᐠ｡ꞈ｡ᐟ\\ ${defaultColor}"
  else
    echo -e "         ${color}/^•˕•^\\ ${defaultColor}"
  fi
}

if [ "$EUID" -eq 0 ]; then
  printCat "$color4" "Please do not run this script as root. Run it as a normal user."
  exit 1
fi

echo ""
cpEcho "Oh, what a boring terminal you have! Don't worry, now we will fix it."
echo ""
cpEcho "             ${color1}Meow            ${color2}Meow            ${color3}Meow"
cpEcho "             ${color1}/               ${color2}/               ${color3}/"
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "         ${color1}/ᐠ｡ꞈ｡ᐟ\\         ${color2}/ᐠ｡ꞈ｡ᐟ\\         ${color3}/ᐠ｡ꞈ｡ᐟ\\ ${defaultColor}"
else
  echo -e "         ${color1}/^•˕•^\\         ${color2}/^•˕•^\\         ${color3}/^•˕•^\\ ${defaultColor}"
fi
cpEcho "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

cpEcho "${color3} Let's start the configuration? ${defaultColor}"
read -p "Press [Enter] to continue or [Ctrl+C] to cancel: "
if [ $? -ne 0 ]; then
  cpEcho "Configuration canceled."
  exit 1
fi

printCat "$color2" "Please, give me your sudo password"
sudo -v

if [[ "$OSTYPE" == "darwin"* ]]; then
  ./macos-install.sh
else
  ./arch-install.sh
fi

# Install oh-my-zsh
printCat "$color1" "Now I will install zsh plugin manager"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
cpEcho "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"

# Rewrite configs
printCat "$color1" "I need to change your .zshrc config."
cp ~/.zshrc ~/.zshrc-backup
cp .zshrc ~/.zshrc
echo ""

printCat "$color1" "And some other configs"
mkdir -p ~/.config
cp .p10k.zsh ~/.p10k.zsh
cp -r bat ~/.config/bat
cp -r .fzf-git.sh ~/.fzf-git.sh
cp -r ghostty ~/.config/ghostty
cp -r yazi ~/.config/yazi
cp -r zellij ~/.config/zellij
echo ""

# Configure Git
printCat "$color1" "Do you want to configure Git for your global environment? [y/n]"
read -r is_git_config
if [ "$is_git_config" == "y" ]; then
  read -p "Enter your Git user name: " git_username
  read -p "Enter your Git email: " git_email

  git config --global user.name "$git_username"
  git config --global user.email "$git_email"
  git config --global core.editor "nvim"
  git config --global color.ui "auto"
  git config --global core.quotepath off
  git config --global push.autoSetupRemote true
  git config --global pull.rebase true

  echo ""
  cpEcho "${color2} Git has been configured successfully!"
  cpEcho "Current Git config:"
  git --no-pager config --global --list
fi

# Install Neovim config
printCat "$color3" "Do you want to install Neovim config? [y/n]"
read -r install_neovim
if [ "$install_neovim" = "y" ]; then
  echo "Do you have a configured SSH-key in GitHub? [y/n]"
  read -r is_ssh_key
  if [ "$is_ssh_key" = "y" ]; then
    git clone git@github.com:Ezhkin-Kot/nvim.git ~/.config/nvim
  else
    git clone https://github.com/Ezhkin-Kot/nvim.git ~/.config/nvim
  fi
  cpEcho "${color3} Neovim has been installed successfully!"
  cpEcho "   ${color5}–––––––––––––––––––––––––––––––––––––––––––––––––––––– ${defaultColor}"
fi

printCat "$color2" "Congratulations! Now your terminal has become excellent!"
if [[ "$OSTYPE" == "darwin"* ]]; then
  open /Applications/Ghostty.app
else
  ghostty
fi
