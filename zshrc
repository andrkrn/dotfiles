export PATH=$PATH:$HOME/bin

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# personal config file
source ~/.zshrc.local

export EDITOR='vi'

# export BUNDLE_GITHUB__COM=<your github token>

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
