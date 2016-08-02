#
# bashrc
#

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Basic settings:
# ======================================================================= #

# set default editor
export EDITOR=vim

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Source additional files
# ======================================================================= #

# ~/.bash_aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# bash-completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Check for color settings
# ======================================================================= #

case "$TERM" in
    xterm-color|*-256color) color_term=yes;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support
	color_term=yes
    else
	color_term=
fi

# Color settings
# ======================================================================= #

# enable color support of ls
if [[ "$color_term" = yes && -x /usr/bin/dircolors ]]; then
    eval `dircolors -b ~/.dircolors`
fi

# variables for ANSI colors
cBlack='\e[0;30m'
cBoldBlack='\e[1;30m'
cRed='\e[0;31m'
cBoldRed='\e[1;31m'
cGreen='\e[0;32m'
cBoldGreen='\e[1;32m'
cYellow='\e[0;33m'
cBoldYellow='\e[1;33m'
cBlue='\e[0;34m'
cBoldBlue='\e[1;34m'
cMagenta='\e[0;35m'
cBoldMagenta='\e[1;35m'
cCyan='\e[0;36m'
cBoldCyan='\e[1;36m'
cWhite='\e[0;37m'
cBoldWhite='\e[1;37m'
cReset='\e[0m'

# colorized man pages
if [ "$color_term" = yes ]; then
    export GROFF_NO_SGR=1
fi

# variables below are as follows:
#   _mb: begin 'blinking'
#   _md: begin BOLD
#   _me: end all effects
#   _se: end 'standout mode'
#   _so: begin 'standout mode'
#   _ue: end underline mode
#   _us: begin underline mode

if [ "$color_term" = yes ]; then
    man() {
        env \
        LESS_TERMCAP_mb=$'\e[01;31m' \
        LESS_TERMCAP_md=$'\e[01;40;37m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[00;45;30m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[00;36m' \
        man "$@"
    }
fi

# tar compression options reminder
reptar() {
    echo "tar compression options:"
    echo
    echo "  -J  --xz"
    echo
    echo "  -j  --bzip2"
    echo
    echo "  -z  --gzip"
}

# Custom Prompt
# ======================================================================= #

# custom prompt and color
if [ "$color_term" = yes ]; then
    PS1="\n\[${cGreen}\]\u \[${cBlue}\]\w \[${cReset}\]\n\$ "
else
    PS1='\n\u \w\n\$ '
fi

