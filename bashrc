# Check for interactive shell.
if [ -n "$PS1" ]; then
    if [ -r /etc/bash_completion ]; then
      # Source completion code.
      . /etc/bash_completion
    fi
fi


PATH=~/.local/bin:$PATH

export PS1='\[\033[01;32m\]\u@$HOSTNAME\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ '

. ~/.profile
