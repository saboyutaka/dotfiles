function reload () {
  source ~/.bash_profile
}

function git_current_branch () {
git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
source /usr/local/git/contrib/completion/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
source /usr/local/git/contrib/completion/git-prompt.sh

PS1=' \[\e[0;36m\]\w $\[\e[00m\]\[\e[0;35m\] $(__git_ps1 "(%s)") \[\e[00m\] \n'
export PS1
