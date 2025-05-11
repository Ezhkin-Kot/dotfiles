color1="\033[1;31m"
color2="\033[1;32m"
color3="\033[1;34m"
color4="\033[1;33m"
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
echo "Oh, what a boring terminal you have! Don't worry, now we will fix it)"
echo ""
echo "             ${color1}Meow            ${color2}Meow            ${color3}Meow"
echo "             ${color1}/               ${color2}/               ${color3}/"
echo "         ${color1}/ᐠ｡ꞈ｡ᐟ\\         ${color2}/ᐠ｡ꞈ｡ᐟ\\         ${color3}/ᐠ｡ꞈ｡ᐟ\\ ${defaultColor}"
echo ""

printCat "$color1" "Please, give me your sudo password"
sudo -v
