# 00-env.zsh - XDG and core environment variables

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Wrangle non-compliant tools
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
[[ "$DOTFILES_PROFILE" == "work" ]] && export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# Relocated tools
# Work-only
if [[ "$DOTFILES_PROFILE" == "work" ]]; then
    export CLOUDSDK_CONFIG="$HOME/.gcloud"
    export NVM_DIR="$HOME/.nvm"
fi

# Python
# Work-only
if [[ "$DOTFILES_PROFILE" == "work" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export CLOUDSDK_PYTHON="$PYENV_ROOT/shims/python"
    export PIPENV_VERBOSITY=-1
fi

# Terraform (work-only)
[[ "$DOTFILES_PROFILE" == "work" ]] && export TFENV_ROOT="$HOME/.tfenv"

# Editor
export EDITOR=nvim
