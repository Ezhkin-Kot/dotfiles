# ===x=== ZSH CONFIG ===x===

typeset -U path PATH

# Dark magic of zsh to get absolute path of dotfiles directory
DOTFILES_DIR="${${(%):-%x}:A:h:h}"

# === Theme Manager ===

# Load themes
[[ -f "$HOME/.zsh/themes/theme-local.zsh" ]] && \
  source "$HOME/.zsh/themes/theme-local.zsh"

path+=("$HOME/.zsh/")

# === Powerlevel10k ===

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# === Oh My Zsh ===

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# == Oh My Zsh plugins ==

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-vi-mode
  web-search
  copyfile
)

ZVM_VI_EDITOR=nvim
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# zsh completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export TERM='xterm-256color'
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [[ "$OSTYPE" == "darwin"* ]]; then
  source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"
elif [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
path=("$HOME/.cargo/bin" $path)
path=("$HOME/.local/bin" $path)

# === FZF ===
eval "$(fzf --zsh)"

# == setup fzf theme ==
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#00DA00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#21ffe5,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="Finds anything)" --border-label-pos="0" --preview-window="border-rounded"
  --prompt="❯ " --marker=" " --pointer="󰜴 " --separator="─"
  --scrollbar="│" --layout="reverse" --info="right"'

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# == fzf-git ==
source ~/.fzf-git.sh/fzf-git.sh

# Set keybindings for zsh-vi-mode insert mode
function zvm_after_init() {
  zvm_bindkey viins "^P" up-line-or-beginning-search
  zvm_bindkey viins "^N" down-line-or-beginning-search
  for o in files branches tags remotes hashes stashes lreflogs each_ref; do
    eval "zvm_bindkey viins '^f^${o[1]}' fzf-git-$o-widget"
    eval "zvm_bindkey viins '^f${o[1]}' fzf-git-$o-widget"
  done
}
# Set keybindings for zsh-vi-mode normal and visual modes
function zvm_after_lazy_keybindings() {
  for o in files branches tags remotes hashes stashes lreflogs each_ref; do
    eval "zvm_bindkey vicmd '^f^${o[1]}' fzf-git-$o-widget"
    eval "zvm_bindkey vicmd '^f${o[1]}' fzf-git-$o-widget"
    eval "zvm_bindkey visual '^f^${o[1]}' fzf-git-$o-widget"
    eval "zvm_bindkey visual '^f${o[1]}' fzf-git-$o-widget"
  done
}

# == fzf preview ==
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# == Advanced customization of fzf options via _fzf_comprun function ==
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# === Yazi ===
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# === Nvim ===
unalias nvim 2>/dev/null
alias n="nvim"
alias nvconf="cd ~/.config/nvim && nvim && cd -"

# === Homebrew ===
alias bi="brew install"
alias bun="brew uninstall"

# === Git aliases ===
alias gs="git status"
alias ga="git add"
alias gust="git restore --staged"
alias grest="git restore"
alias gc="git commit -m"
alias gca="git commit --amend -m"
alias glog="git log --graph --decorate --oneline --all"
alias glogd="git log --graph --decorate --all"
alias gpul="git pull"
alias gpush="git push"
alias gcl="git clone"
alias gsw="git switch"
alias gswf="git branch | fzf | xargs git switch"
alias gbr="git branch"
alias gbrc="git checkout -b"
alias gch="git checkout"
alias gpset="git push --set-upstream origin"
alias gst="git stash"
alias gsp="git stash pop"

# === Eza ===
alias ls="eza --icons=always"
alias lsa="eza --icons=always -a"
alias lst="eza --icons=always --tree"
alias lstl="eza --icons=always --tree --level"

# === Zoxide ===
eval "$(zoxide init zsh)"
alias cd="z"

# === Bat ===
export BAT_THEME="Catppuccin Mocha"

# === Zellij ===
alias zel="zellij"

# === TheFuck ===
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# === gcc ===
alias g++="g++-15"

# === Go ===
alias gob="go build"
alias gor="go run"
alias air='~/go/bin/air'

# === Rust ===
alias cr="cargo run"
alias cb="cargo build"
alias ca="cargo add"
alias ci="cargo install"
alias cfm="cargo fmt"
alias cch="cargo check"
alias ccl="cargo clippy"
alias cinit="cargo init"

# === Typst ===
alias tc="typst compile"
alias tcm="typst compile main.typ"
alias tw="typst watch"
alias twm="typst watch main.typ"

# === Dotnet ===
export DOTNET_ROOT=/usr/local/share/dotnet
path+=("$DOTNET_ROOT")
alias db="dotnet build"
alias dr="dotnet run"

# === Docker ===
alias docup="docker-compose up"
alias docupb="docker-compose up --build"
alias docupn="docker-compose up --no-start"
alias docupbn="docker-compose up --build --no-start"
alias docdown="docker-compose down"
alias docst="docker start"
alias docsp="docker stop"

# === Tailscale ===
alias tsup="tailscale up"
alias tsd="tailscale down"
alias tss="tailscale status"
alias tsip="tailscale ip"

# === arduino-cli ===
alias arc="arduino-cli"

arduino_select_fqbn() {
  local LINE
  local CACHE="$HOME/.arduino_last_fqbn"

  LINE=$(arduino-cli board listall \
    | sed 1d \
    | fzf --prompt="Select board: " \
          --query="$(cat "$CACHE" 2>/dev/null)")

  [ -z "$LINE" ] && return 1

  echo "$LINE" | awk '{print $NF}' | tee "$CACHE"
}

arcc() {
  local FQBN

  FQBN=$(arduino_select_fqbn) || return 1

  echo "Compiling for $FQBN"
  arduino-cli compile --fqbn "$FQBN" .
}

arcu() {
  local PORT FQBN

  PORT=$(arduino-cli board list \
    | awk 'NR>1 {print $1}' \
    | fzf --prompt="Select port: ")

  [ -z "$PORT" ] && return 1

  FQBN=$(arduino_select_fqbn) || return 1

  echo "Compiling for $FQBN"
  arduino-cli compile --fqbn "$FQBN" . || return 1

  echo "Uploading to $PORT"
  arduino-cli upload -p "$PORT" --fqbn "$FQBN" .
}

# === Edit this config ===
alias ndot="cd $DOTFILES_DIR && nvim && cd -"
alias nzsh="nvim ~/.zshrc"
alias rzsh="
source ~/.zshrc
exec zsh"

# === Misc ===
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias of="open -a Finder ."
  alias opdf="open -a Skim"
fi

# === Env ===
source $HOME/.zsh/.env

# === Reminder ===
# Prints the content of the .tasks file to the terminal at every shell startup
cat $HOME/.tasks
