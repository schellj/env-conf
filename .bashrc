# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ -n "$EMACS" ]; then
    export TERM=xterm-256color
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm*color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_DESCRIBE_STYLE="branch"
source ~/.git-prompt.sh
source ~/.kube-prompt.sh

# if [ "$color_prompt" = yes ]; then
#     PS1='\e[1;36;40m[${debian_chroot:+($debian_chroot)}\e[31m\W\e[32m$(__git_ps1)\e[36m]\$\e[8m \e[m'
#     # PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]]\$ '
# else
#     PS1='\e[1;36;40m[${debian_chroot:+($debian_chroot)}\e[31m\W\e[32m$(__git_ps1)\e[36m]\$\e[8m \e[m'
# fi
# unset color_prompt force_color_prompt

PS1='\[\e[1;36;40m\][\[\e[1;32m\]\W\[\e[1;31m\]$(__git_ps1)$(__kube_ps1)\[\e[1;36m\]]\$\[\e[1;8m\] \[\e[m\]'

# case "$TERM" in
# xterm*|rxvt*)
#     # PROMPT_COMMAND='__git_ps1 "\[\e[1;36;40m\][\[\e[32m\W\e[31m" "\e[36m\]]\$\[\e[8m\] \[\e[m\]"'
# #    PS1='\e[1;36;40m[${debian_chroot:+($debian_chroot)}\e[32m\W\e[31m$(__git_ps1)\e[36m]\$\e[8m \e[m'
# #    PS1='\e[1;36;40m[\e[32m\W\e[31m$(__git_ps1)\e[36m]\$\e[8m \e[m'
#     ;;
# *)
#     ;;
# esac

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

bind "set completion-ignore-case on"

export PERLLIB="$HOME/gtperl"
export PERL5LIB="$HOME/gtperl"
export PERL_CPANM_OPT='--sudo'
export MYSQL_PS1="[\u \d]$ "
export GOPATH=~/go
export GPG_TTY=$(tty)
export GIT_TERMINAL_PROMPT=1
export GOPRIVATE=github.com/gudtech
export GOBIN=~/go/bin

mutagen daemon start
