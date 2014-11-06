# Check for interactive shell.
if [ -n "$PS1" ]; then
    if [ -r /etc/bash_completion ]; then
      # Source completion code.
      . /etc/bash_completion
    fi
fi


PATH=$PATH:~/.local/bin

. ~/.profile
