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

# start tmux
if which tmux >/dev/null 2>&1; then
    # if not inside a tmux session, and if no session is started, start a new session
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi

# Source additional files
# ======================================================================= #

# ~/.bash_aliases file
if [ -f ~/.bash_aliases ] ; then
    . ~/.bash_aliases
fi

# bash-completion
if ! shopt -oq posix ; then
  if [ -f /usr/share/bash-completion/bash_completion ] ; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ] ; then
    . /etc/bash_completion
  fi
fi

# Check for color settings
# ======================================================================= #

case "$TERM" in
    xterm-color|*-256color) color_term=yes;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null ; then
	# We have color support
	color_term=yes
    else
	color_term=
fi

# Color settings
# ======================================================================= #

# enable color support of ls
if [[ "$color_term" = yes && -x /usr/bin/dircolors ]] ; then
    eval `dircolors -b ~/.dircolors`
fi

# variables for ANSI colors

# Reset
Color_Reset='\e[0m'

# Regular Colors
Black='\e[0;30m'
Red='\e[0;31m'
Green='\e[0;32m'
Yellow='\e[0;33m'
Blue='\e[0;34m'
Magenta='\e[0;35m'
Cyan='\e[0;36m'
White='\e[0;37m'

# Bold Colors
BBlack='\e[1;30m'
BRed='\e[1;31m'
BGreen='\e[1;32m'
BYellow='\e[1;33m'
BBlue='\e[1;34m'
BMagenta='\e[1;35m'
BCyan='\e[1;36m'
BWhite='\e[1;37m'

# Background
On_Black='\e[0;40m'
On_Red='\e[0;41m'
On_Green='\e[0;42m'
On_Yellow='\e[0;43m'
On_Blue='\e[0;44m'
On_Magenta='\e[0;45m'
On_Cyan='\e[0;46m'
On_White='\e[0;47m'

# Bold Background (?)
On_BBlack='\e[1;40m'
On_BRed='\e[1;41m'
On_BGreen='\e[1;42m'
On_BYellow='\e[1;43m'
On_BBlue='\e[1;44m'
On_BMagenta='\e[1;45m'
On_BCyan='\e[1;46m'
On_BWhite='\e[1;47m'

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
#if [ "$color_term" = yes ]; then
#    PS1="\n\[${Green}\]\u \[${Blue}\]\w \[${Color_Reset}\]\n\$ "
#else
#    PS1='\n\u \w\n\$ '
#fi

# git-aware prompt
source ~/.git-prompt.sh

PROMPT_COMMAND='__git_ps1 "arg1" "arg2" ; \
    echo -ne "\033]0;${USER}@${HOSTNAME}: $(basename ${PWD})\007"'

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1

# remove duplicate entries from PATH
# as seen in: https://unix.stackexchange.com/questions/40749/remote-duplicate-path-entries-with-awk-command

if [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*}            # the first remaining entry
        case $PATH: in
            *:"$x":*) ;;             # already there
            *) PATH=$PATH:$x;;       # not there yet
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
fi

# source local file, if it exists
if [ -r "${HOME}/.bashrc.local" ] ; then
    . "${HOME}/.bashrc.local"
fi
