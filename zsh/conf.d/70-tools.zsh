# 70-tools.zsh - Tool initializations

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv
eval "$(pyenv init - zsh)"

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# rust (uncomment if needed)
# [[ -e "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# fzf key bindings and fuzzy completion
(( $+commands[fzf] )) && source <(fzf --zsh)

# gcloud
[[ -f ~/google-cloud-sdk/path.zsh.inc ]] && source ~/google-cloud-sdk/path.zsh.inc
[[ -f ~/google-cloud-sdk/completion.zsh.inc ]] && source ~/google-cloud-sdk/completion.zsh.inc

# zsh plugins
source ~/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.local/share/zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# powerlevel10k
source ~/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
