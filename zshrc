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

# gco: like `git checkout`, but if the target branch is already checked out in
# another worktree, cd into that worktree instead of failing with
# "fatal: '<branch>' is already used by worktree at ...".
# Overrides the oh-my-zsh git-plugin `gco` alias.
unalias gco 2>/dev/null
gco() {
  # Only intercept a single plain branch arg; pass through flags, -b, files, `-`, multi-arg.
  if [[ $# -ne 1 || "$1" == -* ]]; then
    git checkout "$@"
    return
  fi

  local branch="$1"
  local current_root wt
  current_root=$(git rev-parse --show-toplevel 2>/dev/null)

  wt=$(git worktree list --porcelain 2>/dev/null | awk -v b="refs/heads/$branch" '
    /^worktree /{wt=substr($0, 10)}
    $0 == "branch " b {print wt; exit}
  ')

  if [[ -n "$wt" && "$wt" != "$current_root" ]]; then
    echo "Branch '$branch' lives in another worktree — switching:"
    echo "  $wt"
    cd "$wt"
  else
    git checkout "$branch"
  fi
}
# Restore branch/tag completion lost when gco stopped being a `git checkout` alias.
# Replicate alias-expansion (`gco x` -> `git checkout x`) then dispatch via _normal,
# instead of the `compdef _git gco=git-checkout` service form which triggers a bug in
# git's bundled zsh completion (__git_find_on_cmdline: unknown condition: -lt).
_gco() {
  words=(git checkout "${(@)words[2,-1]}")
  (( CURRENT++ ))
  _normal
}
compdef _gco gco
