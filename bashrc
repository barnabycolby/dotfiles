#
# ~/.bashrc
#

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and update the LINES and COLUMNS values if necessary
shopt -s checkwinsize

# Enable alias commands
shopt -s expand_aliases

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Git aliases
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gm='git merge'
alias gp='git push'
alias gs='git status'
alias gu='git add -u'

alias search='grep -rn . -e'

# Enable globstar (**)
shopt -s globstar

# Load the terminal colour scheme
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_paraiso
