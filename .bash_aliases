if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias ll='ls --color=auto -alF'
    alias la='ls --color=auto -aF'
    alias l='ls --color=auto -F'
else
    alias ll='ls -alF'
    alias la='ls -aF'
    alias l='ls -F'
fi

alias find='find -L'
alias cd='cd -P'
