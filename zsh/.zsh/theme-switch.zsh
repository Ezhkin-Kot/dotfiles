#!/bin/zsh

THEMES=(ash chalk custom)

STATE_FILE="$HOME/.zsh/themes/theme-local.zsh"
ZELLIJ_THEMES="$HOME/.config/zsh/zellij-themes.zsh"

function apply_zellij_theme() {
  export ZELLIJ_THEME="$1"
  source "$ZELLIJ_THEMES"
}

function apply_p10k_theme() {
  export P10K_THEME="$1"
  [[ -f $HOME/.p10k.zsh ]] && source $HOME/.p10k.zsh
}

function apply_ghostty_theme() {
  export GHOSTTY_THEME="$1"
  sed -i '' "s/^theme =.*/theme = $1/" $HOME/.config/ghostty/config
}

function save_state() {
  cat > "$STATE_FILE" <<EOF
export ZELLIJ_THEME="${ZELLIJ_THEME}"
export P10K_THEME="${P10K_THEME}"
export GHOSTTY_THEME="${GHOSTTY_THEME}"
EOF
}

function fzf_pick() {
  printf '%s\n' "${THEMES[@]}" | fzf \
    --prompt "theme > " \
    --height 6 \
    --layout reverse \
    --border rounded \
    --no-info
}

is_valid_theme() {
  printf '%s\n' "${THEMES[@]}" | grep -qx "$1"
}

usage() {
  local s=$(basename "$0")
  echo "Usage:"
  echo "  $s -a <theme>    — all programs"
  echo "  $s -z <theme>    — zellij only"
  echo "  $s -p <theme>    — p10k only"
  echo "  $s -g <theme>    — ghostty only"
  echo "  $s -zp <theme>   — zellij + p10k"
  echo "  $s -f <flags>    — pick theme via fzf, e.g: -f -zp"
  echo ""
  echo "Available themes: ${THEMES[*]}"
}

USE_FZF=false
if [[ "$1" == "-f" ]]; then
  USE_FZF=true
  shift
fi

FLAG="$1"
THEME="$2"

if $USE_FZF; then
  THEME=$(fzf_pick) || exit 1
elif [[ -z "$THEME" ]] || ! is_valid_theme "$THEME"; then
  [[ -n "$THEME" ]] && echo "Unknown theme: $THEME"
  usage; exit 1
fi

case "$FLAG" in
  -a)      apply_z=true;  apply_p=true;  apply_g=true  ;;
  -z)      apply_z=true;  apply_p=false; apply_g=false ;;
  -p)      apply_z=false; apply_p=true;  apply_g=false ;;
  -g)      apply_z=false; apply_p=false; apply_g=true  ;;
  -zp|-pz) apply_z=true;  apply_p=true;  apply_g=false ;;
  -zg|-gz) apply_z=true;  apply_p=false; apply_g=true  ;;
  -pg|-gp) apply_z=false; apply_p=true;  apply_g=true  ;;
  *)       echo "Unknown flag: $FLAG";   usage; exit 1 ;;
esac

$apply_z && apply_zellij_theme  "$THEME"
$apply_p && apply_p10k_theme    "$THEME"
$apply_g && apply_ghostty_theme "$THEME"
save_state

echo "Theme '$THEME' applied to:"
$apply_z && echo "  zellij"
$apply_p && echo "  p10k"
$apply_g && echo "  ghostty"
