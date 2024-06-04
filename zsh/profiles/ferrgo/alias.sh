#!/usr/bin/env bash

# LS
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls -G'

# Git
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'

# ammenities
alias termcolors='for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+"\n"}; done'

alias aws-login='. ~/prj/dev/hfg/aws-autheticator/aws_login.sh'
