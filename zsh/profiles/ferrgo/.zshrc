#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/ferrgo/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## FREEGGING BEEP
unsetopt BEEP

## ZSH

# Hist Options
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

# Navigation
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
#setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

#key=(
 #  BackSpace  "${terminfo[kbs]}"
 #   Home       "${terminfo[khome]}"
 #   End        "${terminfo[kend]}"
 #   Insert     "${terminfo[kich1]}"
 #   Delete     "${terminfo[kdch1]}"
 #   Up         "${terminfo[kcuu1]}"
 #   Down       "${terminfo[kcud1]}"
   # Left       "${terminfo[kcub1]}"
  #  Right      "${terminfo[kcuf1]}"
 #   PageUp     "${terminfo[kpp]}"
 #   PageDown   "${terminfo[knp]}"
#)

# Completions
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit 
[ -f $ZDOTDIR/plugins/asdf.plugin.zsh ] && source $ZDOTDIR/plugins/asdf.plugin.zsh
complete -C 'aws_completer' aws

# History Search
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
# autoload -U up-line-or-beginning-search
# aautoload -U down-line-or-beginning-search
# azle -N up-line-or-beginning-search
# azle -N down-line-or-beginning-search
# bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search # Up
# abindkey "${terminfo[kcud1]}" down-line-or-beginning-search # Down

## Alias

[ -f $ZDOTDIR/alias.sh ] && source $ZDOTDIR/alias.sh


## P10k Theme
source $ZDOTDIR/themes/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

## Plugins
[ -f $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f $ZDOTDIR/plugins/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh ] && source $ZDOTDIR/plugins/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh
