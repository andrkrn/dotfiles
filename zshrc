export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/bin:$PATH
export EDITOR='vim'

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

if [[ `uname` == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# personal config file
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# export BUNDLE_GITHUB__COM=<your github token>

eval "$(~/.local/bin/mise activate zsh)"

yw() {
  # Find .yw-config by traversing up from current directory
  local config_file=""
  local current_dir="$PWD"

  while [[ "$current_dir" != "/" ]]; do
    if [[ -f "$current_dir/.yw-config" ]]; then
      config_file="$current_dir/.yw-config"
      break
    fi
    current_dir=$(dirname "$current_dir")
  done

  if [[ -z "$config_file" ]]; then
    echo "Error: .yw-config not found in project directory"
    return 1
  fi

  # Read the scope from .yw-config
  local scope=$(cat "$config_file" | tr -d '[:space:]')

  if [[ -z "$scope" ]]; then
    echo "Error: .yw-config is empty"
    return 1
  fi

  yarn workspace "$scope/$1" "${@:2}"
}

