set -q color_right_time; or set color_right_time red
set -q color_right_time_indicator; or set color_right_time_indicator yellow
set left_segment_separator \uE0B2

function prompt_time -d 'prints the current time'
  set_color $color_right_time
  echo "$left_segment_separator"
  set_color -b $color_right_time $color_right_time_indicator
  date "+%H:%M:%S"
  set_color -b $color_right_time normal
  echo "$left_segment_separator"
end

function fish_right_prompt -d 'Prints right prompt'
  prompt_time
  set_color normal
end

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

# Miscellaneous aliases
alias vimr='vim -R'

# Exit easily
alias q='exit'

# Copy and paste.
alias c='xclip -selection clipboard'
