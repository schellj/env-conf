if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls --color=auto -alF'
alias la='ls --color=auto -AF'
alias l='ls --color=auto -F'
alias find='find -L'
alias cd='cd -P'
alias db01='ssh jschell@db01.gudtech.com'
alias db05='ssh jschell@db05.gudtech.com'
alias proc01='ssh jschell@proc01.gudtech.com'
alias service01='ssh jschell@service01.gudtech.com'
alias service02='ssh jschell@service02.gudtech.com'
alias dev='ssh gt@jschell1.dev.gudtech.com'
alias compute01='ssh jschell@compute01.gudtech.com'
