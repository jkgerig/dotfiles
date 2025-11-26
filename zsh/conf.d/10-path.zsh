# 10-path.zsh - PATH modifications

# Work-only paths
if [[ "$DOTFILES_PROFILE" == "work" ]]; then
    # pyenv
    [[ -d $PYENV_ROOT/bin ]] && path=("$PYENV_ROOT/bin" $path)

    # tfenv
    path=("$TFENV_ROOT/bin" $path)

    # postgresql (macOS only)
    [[ "$DOTFILES_OS" == "macos" ]] && path=("/opt/homebrew/opt/postgresql@13/bin" $path)
fi

# local bin (all profiles)
path+=("$HOME/.local/bin")

export PATH
