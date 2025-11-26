# 20-aliases.zsh - Aliases and functions

# vim/neovim
alias vim=nvim
alias nvim-lazy='NVIM_APPNAME="nvim-lazy" nvim'

# ls
alias ls='ls -hF --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -al --color=auto'
alias l='ls -ACF --color=auto'

# repos
# Work-only paths
if [[ "$DOTFILES_PROFILE" == "work" ]]; then
    alias rdata="cd $HOME/recidiviz/recidiviz-data"
fi

alias pshell="pipenv shell"

# fzf goodies
alias wtf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'
alias v='fd --type f --hidden --exclude .git | fzf --height=40% --reverse --border | xargs -r nvim'
