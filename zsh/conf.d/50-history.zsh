# 50-history.zsh - History configuration

SHELL_SESSIONS_DISABLE=1 # disable macos terminal restoration

HISTFILE=~/.local/share/zsh/history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history
