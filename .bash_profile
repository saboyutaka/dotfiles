source ~/.aliases

# iTerm2 Tab title
export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'

# rbenv
eval "$(rbenv init -)"

# rails binstubs
export PATH="./.bundle/bin:$PATH"

# added by Anaconda3 4.3.1 installer
export PATH="/Users/yutaka/anaconda/bin:$PATH"
