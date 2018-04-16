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

# Colors (including extra \[ and \] to surround non-printed codes in PS1
     BLACK="\[\033[0;30m\]"
       RED="\[\033[0;31m\]"
     GREEN="\[\033[0;32m\]"
    YELLOW="\[\033[0;33m\]"
      BLUE="\[\033[0;34m\]"
   MAGENTA="\[\033[0;35m\]"
      CYAN="\[\033[0;36m\]"
     WHITE="\[\033[0;37m\]"
COLOR_NONE="\[\033[0m\]"

# I'll handle the VIRTUAL_ENV prompt on my own thank you very much
VIRTUAL_ENV_DISABLE_PROMPT=1

__set_ps1 () {
    PY_VENV_STRING=""
    git_head=''
    git_changed=''
    git_new=''
    git_staged=''
    GIT_STATUS=''
    GIT_BRANCH=''
    GIT_STRING=''

    # Python Virtual Environment
	if [[ -n $CONDA_DEFAULT_ENV ]] && [[ -n $VIRTUAL_ENV ]] ; then
		PY_VENV_STRING="${RED}{BAD!}${COLOR_NONE} "
    elif [[ -n $CONDA_DEFAULT_ENV ]] ; then
        PY_VENV_STRING="${MAGENTA}{${CONDA_DEFAULT_ENV}}${COLOR_NONE} "
    elif [[ -n $VIRTUAL_ENV ]] ; then
        PY_VENV_STRING="${MAGENTA}{`basename \"$VIRTUAL_ENV\"`}${COLOR_NONE} "
    fi

    # check if we are in git repository
    if $(git rev-parse --git-dir >/dev/null 2>/dev/null); then
        # check if we are in .git dir of repo
        if $(git rev-parse --is-inside-git-dir 2>/dev/null); then
            # ahh!!!
            GIT_STATUS="${RED}"
            GIT_BRANCH="(_GIT DIR!_)"
        else
            # check status
            $(git diff --no-ext-diff --quiet) || git_changed='yes'
            $(git ls-files --others --exclude-standard --directory \
                --no-empty-directory --error-unmatch -- ':/*' \
                > /dev/null 2> /dev/null) && git_new='yes'
            $(git diff --no-ext-diff --cached --quiet) || git_staged='yes'

            # set GIT_STATUS
            if [ -z $git_changed ] && [ -z $git_new ] ; then
                if [ -z $git_staged ] ; then
                    GIT_STATUS="${GREEN}"
                else
                    GIT_STATUS="${YELLOW}"
                fi
            else
                GIT_STATUS="${RED}"
            fi

            # set GIT_BRANCH
            if git_head=$(git symbolic-ref --short -q HEAD); then
                GIT_BRANCH=$git_head
            else
                GIT_BRANCH="(_DETACHED_)"
            fi
        fi
        GIT_STRING="${GIT_STATUS}(${GIT_BRANCH})${COLOR_NONE} "
    fi

    PS1="${PY_VENV_STRING}${BLUE}\u${COLOR_NONE}:${CYAN}\w${COLOR_NONE} ${GIT_STRING}\$ "
}

PROMPT_COMMAND='__set_ps1'

# Use `printf '\033[1 q'` to set blinking, block cursor
printf '\033[1 q' 

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

if [ -r ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi


