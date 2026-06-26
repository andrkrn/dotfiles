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

eval "$(direnv hook zsh)"

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


export CLAUDE_CODE_MAX_OUTPUT_TOKENS=64000

# Recover terminal after a remote/TUI session leaves mouse reporting on.
# When ssh/tmux/vim exits uncleanly it can skip the "disable mouse" escape
# sequences, so cursor movement gets injected as garbage input. This runs
# before every prompt and turns mouse reporting back off.
autoload -Uz add-zsh-hook
_reset_mouse_reporting() {
  printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l\e[?1015l' >/dev/tty 2>/dev/null
}
add-zsh-hook precmd _reset_mouse_reporting
