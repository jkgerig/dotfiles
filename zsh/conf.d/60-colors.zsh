# 60-colors.zsh - Catppuccin Mocha theme colors

# zsh-syntax-highlighting catppuccin theme (must be sourced BEFORE the plugin)
source ~/.config/zsh/colorschemes/catppuccin-mocha.zsh

# fzf catppuccin mocha colors
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

# ls colors
export LS_COLORS="di=1;34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Completion colors (must come after LS_COLORS is set)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
