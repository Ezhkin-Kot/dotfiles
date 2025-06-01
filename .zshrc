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
plugins=( git zsh-syntax-highlighting zsh-autosuggestions zsh-vi-mode )

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

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

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
export PATH=$PATH:$HOME/.local/bin
export PATH="$HOME/.local/bin:$PATH"

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
alias gc="git commit -m"
alias gca="git commit --amend -m"
alias gcl="git clone"
alias glog="git log --oneline"
alias gpull="git pull"
alias gpush="git push"
alias gswitch="git switch"
alias gbranch="git branch"
alias gpset="git push --set-upstream origin"
alias ГООЛ="
echo ГОООООООООООООООООООООООООООООООЛ
git"

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
alias g++="g++-14"

# === Go ===
alias gob="go build"
alias gor="go run"

# === Dotnet ===
export DOTNET_ROOT=/usr/local/share/dotnet
export PATH=$PATH:$DOTNET_ROOT
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

# === Edit this config ===
alias nzsh="nvim ~/.zshrc"
alias rzsh="source ~/.zshrc"
