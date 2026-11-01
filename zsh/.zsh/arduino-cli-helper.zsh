ARDUINO_CACHE="$HOME/.arduino_cli_cache"

arduino_cache_get() {
  local KEY="$1"
  grep -m1 "^${KEY}=" "$ARDUINO_CACHE" 2>/dev/null | cut -d= -f2-
}

arduino_cache_set() {
  local KEY="$1"
  local VALUE="$2"
  local TMP="${ARDUINO_CACHE}.tmp"

  touch "$ARDUINO_CACHE"

  grep -v "^${KEY}=" "$ARDUINO_CACHE" > "$TMP" 2>/dev/null
  printf '%s=%s\n' "$KEY" "$VALUE" >> "$TMP"

  mv "$TMP" "$ARDUINO_CACHE"
}

arduino_select_fqbn() {
  local LINE
  local FQBN
  local LAST_FQBN
  local QUERY
  local CPU

  LAST_FQBN=$(arduino_cache_get "fqbn")

  QUERY=$(echo "$LAST_FQBN" | awk -F: '{print $3}')

  LINE=$(arduino-cli board listall \
    | sed 1d \
    | fzf --prompt="Select board: " --query="$QUERY")

  [ -z "$LINE" ] && return 1

  FQBN=$(echo "$LINE" | awk '{print $NF}')

  if [ "$FQBN" = "arduino:avr:nano" ]; then
    CPU=$(printf '%s\n' \
      "atmega328p" \
      "atmega328old" \
      | fzf --prompt="Select Nano bootloader: " \
            --query="$(echo "$LAST_FQBN" | grep -o 'cpu=.*' | cut -d= -f2)")

    [ -z "$CPU" ] && return 1

    FQBN="arduino:avr:nano:cpu=$CPU"
  fi

  arduino_cache_set "fqbn" "$FQBN"
  echo "$FQBN"
}

arduino_get_fqbn() {
  local FQBN

  FQBN=$(arduino_cache_get "fqbn")

  if [ -z "$FQBN" ]; then
    FQBN=$(arduino_select_fqbn) || return 1
  fi

  echo "$FQBN"
}

arduino_select_port() {
  local PORTS
  local LAST_PORT
  local QUERY
  local PORT

  PORTS=$(arduino-cli board list \
    | awk 'NR > 1 && $1 ~ /^\/dev\// {print $1}')

  if [ -z "$PORTS" ]; then
    echo "No Arduino ports found."
    return 1
  fi

  LAST_PORT=$(arduino_cache_get "port")

  QUERY=""
  if echo "$PORTS" | grep -Fxq "$LAST_PORT"; then
    QUERY="$LAST_PORT"
  fi

  PORT=$(printf '%s\n' "$PORTS" \
    | fzf --prompt="Select port: " --query="$QUERY")

  [ -z "$PORT" ] && return 1

  arduino_cache_set "port" "$PORT"
  echo "$PORT"
}

arcc() {
  local FQBN

  FQBN=$(arduino_get_fqbn) || return 1

  echo "Compiling for $FQBN"
  arduino-cli compile --fqbn "$FQBN" .
}

arcu() {
  local FQBN
  local PORT
  local SELECT_BOARD=false
  local SELECT_BOTH=false

  while getopts "bap" opt; do
    case "$opt" in
      b) SELECT_BOARD=true ;;
      a) SELECT_BOTH=true ;;
      p) ;;
      *) echo "Usage: arcu [-b] [-a]"
         return 1 ;;
    esac
  done

  if [ "$SELECT_BOARD" = true ] || [ "$SELECT_BOTH" = true ]; then
    FQBN=$(arduino_select_fqbn) || return 1
  else
    FQBN=$(arduino_get_fqbn) || return 1
  fi

  PORT=$(arduino_select_port) || return 1

  echo
  echo "Board: $FQBN"
  echo "Port:  $PORT"
  echo

  echo "Compiling..."
  arduino-cli compile --fqbn "$FQBN" . || return 1

  echo
  echo "Uploading to $PORT..."

  arduino-cli upload -p "$PORT" --fqbn "$FQBN" .
}

