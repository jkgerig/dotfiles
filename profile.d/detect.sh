#!/bin/bash
# ~/.config/profile.d/detect.sh
# Sets DOTFILES_OS, DOTFILES_MACHINE, and DOTFILES_PROFILE

# OS detection
case "$(uname -s)" in
    Darwin) export DOTFILES_OS="macos" ;;
    Linux)  export DOTFILES_OS="linux" ;;
esac

# Machine detection (from local file or hostname)
if [[ -f ~/.config/local/machine ]]; then
    export DOTFILES_MACHINE="$(cat ~/.config/local/machine)"
else
    case "$(hostname -s)" in
        *work*|*office*) export DOTFILES_MACHINE="work-laptop" ;;
        *)               export DOTFILES_MACHINE="personal" ;;
    esac
fi

# Profile derivation
case "$DOTFILES_MACHINE" in
    work-*) export DOTFILES_PROFILE="work" ;;
    *)      export DOTFILES_PROFILE="home" ;;
esac
