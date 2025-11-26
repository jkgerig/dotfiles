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
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# Relocated tools
export CLOUDSDK_CONFIG="$HOME/.gcloud"
export NVM_DIR="$HOME/.nvm"

# Python
export PYENV_ROOT="$HOME/.pyenv"
[[ -x "$PYENV_ROOT/shims/python" ]] && export CLOUDSDK_PYTHON="$PYENV_ROOT/shims/python"
export PIPENV_VERBOSITY=-1

# Terraform
export TFENV_ROOT="$HOME/.tfenv"

# Editor
export EDITOR=nvim
