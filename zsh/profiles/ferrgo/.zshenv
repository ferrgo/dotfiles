# Editor
# Preferred editor for local and remote sessions
# Remote session may not have nvim
# Improvement would be to check available editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# GPG TTY
# GPG on git fails without it
export GPG_TTY=$(tty)

# ZSH History config
export HISTFILE="$ZDOTDIR/.zsh_history"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
# setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY             # Share history between all sessions.
setopt INC_APPEND_HISTORY_TIME	 # Increments after the execution to allow to save the elapsed time
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
# setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
# setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
# setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
# setopt APPEND_HISTORY            # append to history file
# setopt HIST_NO_STORE             # Don't store history commands

# Secrets
[ -f $ZDOTDIR/.secrets.env ] && source $ZDOTDIR/.secrets.env

## ASDF
# NOT SURE WHY ASDF was needed here
#. /Users/hugo.gouveia/.asdf/asdf.sh

#. /Users/hugo.gouveia/.asdf/completions/asdf.bash

# Node ASDF Path
# export PATH=$PATH:/Users/hugo.gouveia/.asdf/shims/node

# WAT? Donno what is that and why is here
# export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"

# bun
# export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"

# IDEA
# export IDEA_PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS"
# export PATH="$IDEA_PATH:$PATH"

# Console Ninja
# PATH=~/.console-ninja/.bin:$PATH

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
