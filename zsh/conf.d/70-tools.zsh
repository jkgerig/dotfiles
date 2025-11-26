# 70-tools.zsh - Tool initializations

# homebrew
[[ "$DOTFILES_OS" == "macos" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv (work-only)
[[ "$DOTFILES_PROFILE" == "work" ]] && eval "$(pyenv init - zsh)"

# rust (uncomment if needed)
# [[ -e "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Work-only
if [[ "$DOTFILES_PROFILE" == "work" ]]; then
    # gcloud
    source ~/google-cloud-sdk/path.zsh.inc
    source ~/google-cloud-sdk/completion.zsh.inc
fi

# zsh plugins
source ~/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.local/share/zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# powerlevel10k
source ~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
