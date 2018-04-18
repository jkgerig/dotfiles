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

## Colors (including extra \[ and \] to surround non-printed codes in PS1
#     BLACK="\[\033[0;30m\]"
#       RED="\[\033[0;31m\]"
#     GREEN="\[\033[0;32m\]"
#    YELLOW="\[\033[0;33m\]"
#      BLUE="\[\033[0;34m\]"
#   MAGENTA="\[\033[0;35m\]"
#      CYAN="\[\033[0;36m\]"
#     WHITE="\[\033[0;37m\]"
#COLOR_NONE="\[\033[0m\]"

# I'll handle the VIRTUAL_ENV prompt on my own thank you very much
VIRTUAL_ENV_DISABLE_PROMPT=1

#__set_ps1 () {
#    PY_VENV_STRING=""
#    git_head=''
#    git_changed=''
#    git_new=''
#    git_staged=''
#    GIT_STATUS=''
#    GIT_BRANCH=''
#    GIT_STRING=''
#
#    # Python Virtual Environment
#	if [[ -n $CONDA_DEFAULT_ENV ]] && [[ -n $VIRTUAL_ENV ]] ; then
#		PY_VENV_STRING="${RED}{BAD!}${COLOR_NONE} "
#    elif [[ -n $CONDA_DEFAULT_ENV ]] ; then
#        PY_VENV_STRING="${MAGENTA}{${CONDA_DEFAULT_ENV}}${COLOR_NONE} "
#    elif [[ -n $VIRTUAL_ENV ]] ; then
#        PY_VENV_STRING="${MAGENTA}{`basename \"$VIRTUAL_ENV\"`}${COLOR_NONE} "
#    fi
#
#    # check if we are in git repository
#    if $(git rev-parse --git-dir >/dev/null 2>/dev/null); then
#        # check if we are in .git dir of repo
#        if $(git rev-parse --is-inside-git-dir 2>/dev/null); then
#            # ahh!!!
#            GIT_STATUS="${RED}"
#            GIT_BRANCH="(_GIT DIR!_)"
#        else
#            # check status
#            $(git diff --no-ext-diff --quiet) || git_changed='yes'
#            $(git ls-files --others --exclude-standard --directory \
#                --no-empty-directory --error-unmatch -- ':/*' \
#                > /dev/null 2> /dev/null) && git_new='yes'
#            $(git diff --no-ext-diff --cached --quiet) || git_staged='yes'
#
#            # set GIT_STATUS
#            if [ -z $git_changed ] && [ -z $git_new ] ; then
#                if [ -z $git_staged ] ; then
#                    GIT_STATUS="${GREEN}"
#                else
#                    GIT_STATUS="${YELLOW}"
#                fi
#            else
#                GIT_STATUS="${RED}"
#            fi
#
#            # set GIT_BRANCH
#            if git_head=$(git symbolic-ref --short -q HEAD); then
#                GIT_BRANCH=$git_head
#            else
#                GIT_BRANCH="(_DETACHED_)"
#            fi
#        fi
#        GIT_STRING="${GIT_STATUS}(${GIT_BRANCH})${COLOR_NONE} "
#    fi
#
#    PS1="${PY_VENV_STRING}${BLUE}\u${COLOR_NONE}:${CYAN}\w${COLOR_NONE} ${GIT_STRING}\$ "
#}
#
#PROMPT_COMMAND='__set_ps1'
#
# Bash prompt adapted by Kris Gerig from:
#
# > Clean and minimalistic Bash prompt
# > Author: Artem Sapegin, sapegin.me
# > 
# > Inspired by: https://github.com/sindresorhus/pure & https://github.com/dreadatour/dotfiles/blob/master/.bash_profile
#
# Source: https://github.com/sapegin/dotfiles/blob/dd063f9c30de7d2234e8accdb5272a5cc0a3388b/includes/bash_prompt.bash
#
# Notes:
# - $local_username - username you don’t want to see in the prompt - can be defined in ~/.bashlocal : `local_username="admin"`
# - Colors ($RED, $GREEN) - defined in ../tilde/bash_profile.bash
#

local_username="kris"

# Colors 
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
GRAY="$(tput setaf 8)"
BOLD="$(tput bold)"
UNDERLINE="$(tput sgr 0 1)"
INVERT="$(tput sgr 1 0)"
NOCOLOR="$(tput sgr0)"

# User color
case $(id -u) in
	0) user_color="$RED" ;;  # root
	*) user_color="$GREEN" ;;
esac

# Symbols
#prompt_symbol=">"
#prompt_symbol="»"
#prompt_symbol="→"
#prompt_symbol="⇒"
#prompt_symbol="⇨"
prompt_symbol="➜"
prompt_clean_symbol="✓ "
prompt_dirty_symbol="✕ "
#prompt_venv_symbol="% "

function prompt_command() {
	# Local or SSH session?
	local remote=
	[ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] && remote=1

	# Git branch name and work tree status (only when we are inside Git working tree)
	local git_prompt=
	if [[ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
		# Branch name
		local branch="$(git symbolic-ref HEAD 2>/dev/null)"
		branch="${branch##refs/heads/}"

		# Working tree status (red when dirty)
		local dirty=
		# Modified files
		git diff --no-ext-diff --quiet --exit-code --ignore-submodules 2>/dev/null || dirty=1
		# Untracked files
		[ -z "$dirty" ] && test -n "$(git status --porcelain)" && dirty=1

		# Format Git info
		if [ -n "$dirty" ]; then
			git_prompt=" $RED$prompt_dirty_symbol$branch$NOCOLOR"
		else
			git_prompt=" $GREEN$prompt_clean_symbol$branch$NOCOLOR"
		fi
	fi

	# Virtualenv
	local venv_prompt=
	if [ -n "$VIRTUAL_ENV" ]; then
	    venv_prompt=" $MAGENTA{$(basename $VIRTUAL_ENV)}$NOCOLOR"
    elif [ -n "$CONDA_DEFAULT_ENV" ]; then
        venv_prompt=" $MAGENTA{$CONDA_DEFAULT_ENV}$NOCOLOR"
	fi

	# Only show username if not default
	local user_prompt=
	[ "$USER" != "$local_username" ] && user_prompt="$user_color$USER$NOCOLOR"

	# Show hostname inside SSH session
	local host_prompt=
	[ -n "$remote" ] && host_prompt="@$YELLOW$HOSTNAME$NOCOLOR"

	# Show delimiter if user or host visible
	local login_delimiter=
	[ -n "$user_prompt" ] || [ -n "$host_prompt" ] && login_delimiter=":"

	# Format prompt
	first_line="$user_prompt$host_prompt$login_delimiter$WHITE\w$NOCOLOR$git_prompt$venv_prompt"
	# Text (commands) inside \[...\] does not impact line length calculation which fixes stange bug when looking through the history
	# $? is a status of last command, should be processed every time prompt prints
	second_line="\`if [ \$? = 0 ]; then echo \[\$CYAN\]; else echo \[\$RED\]; fi\`\$prompt_symbol\[\$NOCOLOR\] "
	PS1="\n$first_line\n$second_line"

	# Multiline command
	PS2="\[$CYAN\]$prompt_symbol\[$NOCOLOR\] "

	# Terminal title
	local title="$(basename "$PWD")"
	[ -n "$remote" ] && title="$title \xE2\x80\x94 $HOSTNAME"
	echo -ne "\033]0;$title"; echo -ne "\007"
}

# Show awesome prompt only if Git is istalled
command -v git >/dev/null 2>&1 && PROMPT_COMMAND=prompt_command

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


