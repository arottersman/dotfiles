#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# # Source Prezto.
# if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# fi

# Customize to your needs...

# vim bindings 
bindkey -v
bindkey -M viins 'fd' vi-cmd-mode

# iterm
# export TERM=xterm-256color

# prompt
# autoload -U promptinit; promptinit
# prompt purer

# rename directories
autoload -U zmv
alias zshmv='noglob zmv -W'

# fuzzy searcher
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# light mode
# export FZF_DEFAULT_OPTS='--color=bg+:230,bg:255,border:255,spinner:17,hl:26,fg:243,header:17,info:167,pointer:167,marker:91,fg+:235,prompt:26,hl+:26'
# dark mode
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# pip executables on path
export PATH=~/.local/bin:$PATH

# go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# bun
export PATH=$HOME/.bun/bin:$PATH

# PSQL
export PSQL_EDITOR="/opt/homebrew/bin/vim"
export VISUAL="/opt/homebrew/bin/vim"
export EDITOR="/opt/homebrew/bin/vim"

# Node Version Manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Handy Dandy Aliases
alias git-del-bs="git branch | grep -v "master" | xargs git branch -D"
alias t20="osascript -e \'display alert \"timer is up!\"\' | at now + 20 minutes"
alias vim="nvim"
alias neovide="/Applications/Neovide.app/Contents/MacOS/neovide"
alias pw_auth="yarn playwright test --project=setup"
alias pw_page="yarn playwright test ./playwright-tests/page-* --retries=0 -u"
alias hb="gh pr list --draft=false --search \"review:required -author:@me\""


export BAT_THEME="Dracula"

function gb () {
    git checkout $(git branch --sort=-committerdate --format="%(committerdate:short) %(refname:short)" | fzf --reverse | cut -d\  -f2)
}

function die_slack_popup () {
    sudo chown -R "$(whoami):staff" /Applications/Slack.app
}

function non_test_diff_stat () {
    echo "git diff --stat master -- ':(exclude)**.spec.ts' ':(exclude)**.test.tsx' ':(exclude)**test/**' ':(exclude)**.test.ts'"
    git diff --stat master -- ':(exclude)**.spec.ts' ':(exclude)**.test.tsx' ':(exclude)**test/**' ':(exclude)**.test.ts'
}


pw() {
  if ! command -v fzf >/dev/null 2>&1; then
    echo "pw: fzf is required (brew install fzf)" >&2
    return 1
  fi

  local dir="$(pwd)" root=""
  while [[ "${dir}" != "/" ]]; do
    if [[ -d "${dir}/playwright-tests" ]]; then
      root="${dir}"
      break
    fi
    dir="$(dirname "${dir}")"
  done

  if [[ -z "${root}" ]]; then
    echo "pw: no playwright-tests directory found from $(pwd) upward" >&2
    return 1
  fi

  local specs
  specs="$(find "${root}/playwright-tests" -name '*.spec.ts' -type f \
    | sed "s|^${root}/playwright-tests/||" | sort)"

  if [[ -z "${specs}" ]]; then
    echo "pw: no *.spec.ts files under ${root}/playwright-tests" >&2
    return 1
  fi

  local selected
  selected="$(printf '%s\n' "${specs}" | fzf --ansi)"
  [[ -z "${selected}" ]] && return 0

  cd "${root}"
  yarn playwright test "playwright-tests/${selected}"
}


# vi mode cursor shape (block in normal, bar in insert)
function zle-keymap-select zle-line-init zle-line-finish
{
  case $KEYMAP in
      vicmd)      print -n '\033[1 q';; # block cursor
      viins|main) print -n '\033[5 q';; # line cursor
  esac
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
