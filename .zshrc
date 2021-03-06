set -o emacs

export PATH="/usr/local/sbin:$PATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export EDITOR=vim
source ~/.aliases

# bindkeys
bindkey "^p" history-search-backward
bindkey "^[[A" history-search-backward
bindkey "^n" history-search-forward
bindkey "^[[B" history-search-forward

# git completion
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit -i

if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# Reirculate suggestion
bindkey '^[[Z' reverse-menu-complete

setopt list_packed
setopt auto_cd

# beep を無効にする
setopt no_beep

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

autoload auto_pushd pushdsilent
autoload -Uz add-zsh-hook
autoload -U colors; colors
autoload -Uz vcs_info

# History
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt share_history
setopt hist_no_store

# Autocompletion
autoload -U compinit
compinit -u
setopt always_last_prompt

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1
# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

function rprompt-git-info {
  local name st color wip ctime timecolor
  local git==git

  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
          return
  fi
  name=`${git} rev-parse --abbrev-ref HEAD 2> /dev/null`
  if [[ -z $name ]]; then
          return
  fi
  st=`${git} status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
          color=${fg[green]}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
          color=${fg[yellow]}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
          color=${fg_bold[red]}
  else
          color=${fg[red]}
  fi

  if [[ `${git} log --oneline -n 1 2> /dev/null | grep 'WIP'` ]]; then
    wip='[WIP]'
  fi

  ctime=`${git} log -n 1 --pretty=format:'%cr' 2> /dev/null`
  timecolor=${fg[blue]}
  echo "%{$color%}$wip %{$reset_color%}(%{$color%}$name%{$reset_color%}) %{$timecolor%}$ctime%{$reset_color%}"
}
setopt prompt_subst

display_git_branch_and_wip_files() {
  echo "${fg[blue]}######################################$reset_color"
  git branch
  echo "${fg[yellow]}######################################$reset_color"
  git status
  echo "${fg[blue]}######################################$reset_color"
}
alias gg='display_git_branch_and_wip_files'

git_log_after_latest_mpr() {
  git log `git_latest_tag`..origin/master --oneline  --grep 'Merge pull request'
}

function git-root() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    cd `pwd`/`git rev-parse --show-cdup`
  fi
}

# z
. `brew --prefix`/etc/profile.d/z.sh

precmd () {
  PROMPT='%F{cyan}%~ $ %f'
  RPROMPT='`rprompt-git-info`'
  z --add "$(pwd -P)"
}

# hub
function git(){hub "$@"}

# peco
bindkey '^]' peco-src

function peco-src() {
  local src=$(ghq list | peco --query "$LBUFFER")
  if [ -n "$src" ]; then
    BUFFER="cd $GHQ_ROOT/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N peco-src

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
change_iterms_prompt() {
  echo -ne "\033]0;${HOSTNAME%%.*}:${PWD/$HOME/~}\007"
}
add-zsh-hook precmd change_iterms_prompt

# rbenv
# eval "$(rbenv init -)"

# python
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# export PATH="$HOME/anaconda/bin:$PATH"
# export PATH=/Users/yutaka/.miniconda3/bin:$PATH
# export PATH=/usr/local/opt/python/libexec/bin:$PATH
# export PATH=$HOME/Library/Python/3.7/bin:$PATH

# nodenv
# export PATH="$HOME/.nodenv/bin:$PATH"
# eval "$(nodenv init -)"
# export PATH=$HOME/.nodebrew/current/bin:$PATH
# export PATH=./node_modules/.bin:$PATH

# phpbrew
# [[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
# export PATH=$HOME/.composer/vendor/bin:$PATH

# rails binstubs
# export PATH="./.bundle/bin:$PATH"
# export PATH="./vendor/bin:$PATH"
# export PATH="./bin:$PATH"

# Go
# export GOPATH=$HOME/Development
# export PATH=$GOPATH/bin:$PATH

# ghq
export GHQ_ROOT=$HOME/Development/src

# Pokemon-terminal
export PATH=$HOME/.local/bin:$PATH

# direnv
# eval "$(direnv hook zsh)"
