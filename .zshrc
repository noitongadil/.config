export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh
alias vv="NVIM_APPNAME=old-vim nvim"
alias v="NVIM_APPNAME=nvim ~/NightlyVim/nvim-macos-arm64/bin/nvim"
alias g++="g++ -std=c++20"

export PATH="$HOME/.local/bin:$PATH"
