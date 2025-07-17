is_wsl = ENV['PATH'].match /WINDOWS\/system32/

brew 'tmux'
brew 'vim'
brew 'ag'
brew 'rg'
brew 'openssl'
brew 'git'
brew 'ffmpeg'
brew 'jq'
brew 'kubectx'
brew 'kubernetes-cli'
brew 'tree'
brew 'stern'
brew 'awscli'
brew 'fzf'
brew 'git-standup'
brew 'ansible'
brew 'cloudflared'

unless is_wsl
  cask 'visual-studio-code'
  cask 'google-chrome'
  cask 'slack'
  cask 'orbstack'
  cask 'licecap'
  cask 'qbittorrent'
  cask 'openvpn-connect'
end
