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
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# pip executables on path
export PATH=~/.local/bin:$PATH

# go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# PSQL
export PSQL_EDITOR="/usr/local/bin/vim"
export VISUAL="/usr/local/bin/vim"
export EDITOR="/usr/local/bin/vim"

# Node Version Manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Handy Dandy Aliases
alias git-del-bs="git branch | grep -v "master" | xargs git branch -D"
alias t20="osascript -e \'display alert \"timer is up!\"\' | at now + 20 minutes"

eval "$(direnv hook zsh)"

export BAT_THEME="GitHub"

function gb () {
    git checkout $(git branch --sort=-committerdate --format="%(committerdate:short) %(refname:short)" | fzf --reverse | cut -d\  -f2)
}
