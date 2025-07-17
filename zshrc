# source homebrew for linux
if [[ `uname` == "Linux" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [[ `uname` == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH=$HOME/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git docker-compose)

source $ZSH/oh-my-zsh.sh

# personal config file
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

export EDITOR='vim'

# export BUNDLE_GITHUB__COM=<your github token>

# Install fzf bindings
# $(brew --prefix)/opt/fzf/install
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(rbenv init -)"
eval "$(~/.local/bin/mise activate zsh)" 

alias claude="$HOME/.claude/local/claude"

