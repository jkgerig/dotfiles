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

# zsh plugins (run 'dotfiles-health' to check/install)
_zsh_plugin_dir="$HOME/.local/share/zsh"
for _plugin in \
    "zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "fzf-tab/fzf-tab.plugin.zsh" \
    "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "powerlevel10k/powerlevel10k.zsh-theme"
do
    if [[ -f "$_zsh_plugin_dir/$_plugin" ]]; then
        source "$_zsh_plugin_dir/$_plugin"
    else
        print -P "%F{yellow}warning:%f missing plugin: $_plugin (run 'dotfiles-health --fix')%f" >&2
    fi
done
unset _zsh_plugin_dir _plugin
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
