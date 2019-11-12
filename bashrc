#
# ~/.bashrc
#

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and update the LINES and COLUMNS values if necessary
shopt -s checkwinsize

# Enable alias commands
shopt -s expand_aliases

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

# Make commands more colourful.
alias diff='diff --color=auto'
alias grep='grep --color=auto'
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
alias ls='ls --color=auto'
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Miscellaneous aliases
alias vimr='vim -R'

# Exit easily
alias q='exit'

# Copy and paste.
alias c='xclip -selection clipboard'

NDK_PATH='~/Android/standalone-toolchains/current-arm/bin'
PATH=${PATH}:~/.local/bin:${NDK_PATH}
PATH=${PATH}:~/.gem/ruby/2.6.0/bin
PATH=${PATH}:~/bin
PATH=${PATH}:~/Android/sdk/platform-tools
PATH=${PATH}:/usr/lib/jvm/java-11-openjdk/bin

# Add custom python files to the python search path.
if [ -z "${PYTHONPATH}" ]; then
    export PYTHONPATH=~/Projects/PythonCrypto
else
    export PYTHONPATH=${PYTHONPATH}:~/Projects/PythonCrypto
fi
