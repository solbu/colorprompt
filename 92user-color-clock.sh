# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 3 of the
# License, or (at your option) any later version.

# Colorize the bash prompt based on which user is currently logged in.
#
# This version put the clock timestamp at the front. It will show the time
# when the previous command was completed. Usefull for commands that take
# some time to complete, and give you an idea of how long ago you 
# did something in the terminal.

# 3x = letter color, 4x = background color, 1 = extra brightness
# x = 0:black 1:red 2:green 3:yellow/brown 4:dark blue 3:purple 6:light blue 7:white

if [ -n "$PS1" ]; then

  # This line duplicated from /etc/bashrc
  [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="(\t) [\u@\h \w]\\$ "

  # Prepare our reset escape seq
  psclear=$'\e[0m'
  psreset=$'\017\e[10;0m'
  if [ "$TERM" = "linux" ]; then
      psreset=$'\017\e[?0c\e[10;0m'
  fi

  # Pick our colors
  colorregex="3[12]m"
  color="32m"
  if [ "$UID" = "0" ]; then
      color="31m"
  fi
  pscolor=$'\e[1;'$color

  # If we've already manipulated the prompt, remaniplate our color
  if echo "$PS1" | grep -q -E "$colorregex" 2>/dev/null; then
    export PS1="$(echo -n "$PS1" | sed "s/$colorregex/$color/")"
  else
    export PS1=$'\\['"$psreset$pscolor"$'\\]'"$PS1"$'\\['"$psreset"$'\\]'
  fi
fi
