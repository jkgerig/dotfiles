# 40-completions.zsh - Completion configuration

# Add zsh-completions to fpath
[[ -d $HOME/.local/share/zsh/zsh-completions/src ]] && fpath=($HOME/.local/share/zsh/zsh-completions/src $fpath)

# Load completions
autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case-insensitive

# fzf-tab config (from https://github.com/Aloxaf/fzf-tab)
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# Note: list-colors zstyle is set in 60-colors.zsh after LS_COLORS is defined
