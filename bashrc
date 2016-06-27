#
# bashrc
#

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Aliases
#==========================================================

# grep colors
alias grep='grep --color'                     
alias egrep='egrep --color=auto'             
alias fgrep='fgrep --color=auto'            

# ls colors, long lists, show `.` files, etc...
alias ls='ls -hF --color=tty'                 
alias ll='ls -al --color=tty'                 
alias la='ls -Al --color=tty'               
alias l='ls -ACF --color=tty'                          

# TAB-completion settings
#==========================================================

# set case-insensitive completion
bind 'set completion-ignore-case on'

# similar to zsh
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# Color settings
#==========================================================

source ~/.bash-colors

## dircolors (colorize ls output w/solarized dark)
#eval `dircolors -b ~/.dir_colors`
#
## variables for ANSI colors
#cBlack='\e[0;30m'
#cBoldBlack='\e[1;30m'
#cRed='\e[0;31m'
#cBoldRed='\e[1;31m'
#cGreen='\e[0;32m'
#cBoldGreen='\e[1;32m'
#cYellow='\e[0;33m'
#cBoldYellow='\e[1;33m'
#cBlue='\e[0;34m'
#cBoldBlue='\e[1;34m'
#cMagenta='\e[0;35m'
#cBoldMagenta='\e[1;35m'
#cCyan='\e[0;36m'
#cBoldCyan='\e[1;36m'
#cWhite='\e[0;37m'
#cBoldWhite='\e[1;37m'
#cReset='\e[0m'
#
## colorized man pages
#export GROFF_NO_SGR=1
## variables below are as follows:
##   _mb: begin 'blinking'
##   _md: begin BOLD
##   _me: end all effects
##   _se: end 'standout mode'
##   _so: begin 'standout mode'
##   _ue: end underline mode
##   _us: begin underline mode
#man() {
#    env \
#    LESS_TERMCAP_mb=$'\e[01;31m' \
#    LESS_TERMCAP_md=$'\e[01;40;37m' \
#    LESS_TERMCAP_me=$'\e[0m' \
#    LESS_TERMCAP_se=$'\e[0m' \
#    LESS_TERMCAP_so=$'\e[00;45;30m' \
#    LESS_TERMCAP_ue=$'\e[0m' \
#    LESS_TERMCAP_us=$'\e[00;36m' \
#    man "$@"
#}
#
## Custom Prompt
##==========================================================
#
## custom prompt and color
#export PS1="\[${cGreen}\]\u \[${cBlue}\]\w \[${cReset}\]\$ "
