source ~/.aliases

# iTerm2 Tab title
export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'

# rbenv
eval "$(rbenv init -)"

# rails binstubs
export PATH="./.bundle/bin:$PATH"

# added by Miniconda3 4.3.21 installer
export PATH="/Users/yutaka/Development/miniconda3/bin:$PATH"
