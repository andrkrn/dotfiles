export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# personal config file
source ~/.zshrc.local

export EDITOR='vi'

# export BUNDLE_GITHUB__COM=<your github token>

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
