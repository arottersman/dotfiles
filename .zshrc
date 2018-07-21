#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# vim bindings 
bindkey -M viins 'fd' vi-cmd-mode

# iterm
export TERM=xterm-256color

# prompt
autoload -U promptinit; promptinit
prompt purer

# rename directories
autoload -U zmv
alias zshmv='noglob zmv -W'

# fuzzy searcher
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pip executables on path
export PATH=~/.local/bin:$PATH

# go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Handy Dandy Aliases
alias cd-dev='cd ~/go/src/github.com'
alias git-del-bs="git branch | grep -v "master" | xargs git branch -D"

eval "$(direnv hook zsh)"
