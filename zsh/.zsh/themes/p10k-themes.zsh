case "${P10K_THEME:-default}" in
  ash)
    COLOR_0="#0f0f0f"
    COLOR_1="#e05c3a"
    COLOR_2="#aaaaaa"
    COLOR_3="#d4a472"
    COLOR_4="#888888"
    COLOR_5="#b09090"
    COLOR_6="#a8a8a8"
    COLOR_7="#c8c8c8"
    COLOR_8="#1a1a1a"
    COLOR_15="#e8e8e8"
    COLOR_GO="#c8c8c8"
    COLOR_DOTNET="#d4a472"
    ;;

  chalk)
    COLOR_0="#f5f2ee"
    COLOR_1="#1a1a1a"
    COLOR_2="#888078"
    COLOR_3="#555048"
    COLOR_4="#666058"
    COLOR_5="#888078"
    COLOR_6="#777068"
    COLOR_7="#2a2520"
    COLOR_8="#ede9e3"
    COLOR_15="#1a1a1a"
    COLOR_GO="#444038"
    COLOR_DOTNET="#555048"
    ;;

  default)
    COLOR_0="#282737"  # black
    COLOR_1="#f38ba8"  # red
    COLOR_2="#abe9b4"  # green
    COLOR_3="#fae3b0"  # yellow
    COLOR_4="#89b4fa"  # blue
    COLOR_5="#cba6f8"  # magenta
    COLOR_6="#89dceb"  # cyan
    COLOR_7="#bfc6d4"  # white
    COLOR_8="#313244"  # bright black
    COLOR_9="#f38ba8"  # bright red
    COLOR_10="#abe9b4" # bright green
    COLOR_11="#fae3b0" # bright yellow
    COLOR_12="#89b4fa" # bright blue
    COLOR_13="#cba6f8" # bright magenta
    COLOR_14="#89dceb" # bright cyan
    COLOR_15="#d9e0ee" # bright white
    COLOR_GO="#76E1FE"
    COLOR_DOTNET="#B078DD"
    ;;

  *)
    echo "Unknown theme: $1"
    echo "Available: catppuccin (default), ash, chalk"
    return 1
    ;;
esac
