# source homebrew for linux
if [[ `uname` == "Linux" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export PATH=$HOME/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git docker-compose kubectl)

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh

# personal config file
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

export EDITOR='vi'

# export BUNDLE_GITHUB__COM=<your github token>

# Install fzf bindings
# $(brew --prefix)/opt/fzf/install
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(rbenv init -)"

source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

loadNodeVersion() {
	if [[ -f .node-version ]]
	then
		local installed=$(nvm list --no-alias | grep -c $(cat .node-version))
		if [[ installed -eq 1 ]]
		then
			nvm use $(cat .node-version)
		else
			nvm install $(cat .node-version)
		fi
	fi
}
add-zsh-hook -Uz chpwd (){ loadNodeVersion }
loadNodeVersion
