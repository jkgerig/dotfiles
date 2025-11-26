# TODO: fix this to create fewer directories and prompt before every action

# #!/bin/bash
# # bootstrap.sh - New machine setup script
# # Run this after cloning the dotfiles repo to ~/.config

# set -e

# echo "=== Dotfiles Bootstrap ==="
# echo

# #-----------------------------------------------------------------------------------------------------------------------
# # Detect OS
# #-----------------------------------------------------------------------------------------------------------------------

# case "$(uname -s)" in
#     Darwin) OS="macos" ;;
#     Linux)  OS="linux" ;;
#     *)      echo "Unsupported OS"; exit 1 ;;
# esac
# echo "Detected OS: $OS"

# #-----------------------------------------------------------------------------------------------------------------------
# # Create necessary directories
# #-----------------------------------------------------------------------------------------------------------------------

# echo "Creating directories..."
# mkdir -p ~/.config/local
# mkdir -p ~/.local/share/zsh
# mkdir -p ~/.local/state/less
# mkdir -p ~/.local/bin
# mkdir -p ~/.cache
# mkdir -p ~/.ssh

# #-----------------------------------------------------------------------------------------------------------------------
# # Set up machine identifier
# #-----------------------------------------------------------------------------------------------------------------------

# if [[ ! -f ~/.config/local/machine ]]; then
#     echo
#     echo "Machine identifier not found."
#     echo "Options: personal, work-laptop, work-desktop"
#     read -p "Enter machine identifier: " machine_id
#     echo "$machine_id" > ~/.config/local/machine
#     echo "Machine identifier set to: $machine_id"
# else
#     echo "Machine identifier already set: $(cat ~/.config/local/machine)"
# fi

# #-----------------------------------------------------------------------------------------------------------------------
# # Set up ~/.zshenv for ZDOTDIR
# #-----------------------------------------------------------------------------------------------------------------------

# ZSHENV_CONTENT='# set XDG variables
# if [[ -z "$XDG_CONFIG_HOME" ]]
# then
# 	export XDG_CONFIG_HOME="$HOME/.config"
# fi

# if [[ -z "$XDG_DATA_HOME" ]]
# then
# 	export XDG_DATA_HOME="$HOME/.local/share"
# fi

# if [[ -z "$XDG_STATE_HOME" ]]
# then
# 	export XDG_STATE_HOME="$HOME/.local/state"
# fi

# if [[ -z "$XDG_CACHE_HOME" ]]
# then
# 	export XDG_CACHE_HOME="$HOME/.cache"
# fi

# # set ZDOTDIR
# if [[ -d "$XDG_CONFIG_HOME/zsh" ]]
# then
# 	export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# fi'

# if [[ ! -f ~/.zshenv ]]; then
#     echo "Creating ~/.zshenv..."
#     echo "$ZSHENV_CONTENT" > ~/.zshenv
# else
#     echo "~/.zshenv already exists, skipping"
# fi

# #-----------------------------------------------------------------------------------------------------------------------
# # Set up git profile symlink
# #-----------------------------------------------------------------------------------------------------------------------

# # Derive profile from machine identifier
# machine_id=$(cat ~/.config/local/machine)
# case "$machine_id" in
#     work-*) profile="work" ;;
#     *)      profile="home" ;;
# esac

# echo "Setting up git config-profile symlink for profile: $profile"
# ln -sf "config-$profile" ~/.config/git/config-profile

# # Work-only directories
# if [[ "$profile" == "work" ]]; then
#     mkdir -p ~/.gcloud
#     mkdir -p ~/.nvm
# fi

# #-----------------------------------------------------------------------------------------------------------------------
# # Install 1Password CLI (if not present)
# #-----------------------------------------------------------------------------------------------------------------------

# if ! command -v op &> /dev/null; then
#     echo
#     echo "1Password CLI not found."
#     read -p "Install 1Password CLI? [y/N] " install_op
#     if [[ "$install_op" =~ ^[Yy]$ ]]; then
#         if [[ "$OS" == "macos" ]]; then
#             echo "Installing via Homebrew..."
#             brew install --cask 1password-cli
#         elif [[ "$OS" == "linux" ]]; then
#             echo "Please install 1Password CLI manually:"
#             echo "  https://developer.1password.com/docs/cli/get-started/"
#         fi
#     fi
# else
#     echo "1Password CLI already installed: $(op --version)"
# fi

# #-----------------------------------------------------------------------------------------------------------------------
# # Set up SSH config for 1Password agent (macOS)
# #-----------------------------------------------------------------------------------------------------------------------

# if [[ "$OS" == "macos" ]]; then
#     SSH_CONFIG_1P='Host *
#     IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'

#     if [[ ! -f ~/.ssh/config ]]; then
#         echo "Creating ~/.ssh/config for 1Password SSH agent..."
#         echo "$SSH_CONFIG_1P" > ~/.ssh/config
#         chmod 600 ~/.ssh/config
#     elif ! grep -q "1password" ~/.ssh/config; then
#         echo
#         echo "Add this to ~/.ssh/config for 1Password SSH agent:"
#         echo "$SSH_CONFIG_1P"
#     fi
# fi

# #-----------------------------------------------------------------------------------------------------------------------
# # Summary
# #-----------------------------------------------------------------------------------------------------------------------

# echo
# echo "=== Bootstrap Complete ==="
# echo
# echo "Next steps:"
# echo "  1. Restart your shell or run: source ~/.zshenv && source ~/.config/zsh/.zshrc"
# echo "  2. Sign into 1Password: op signin"
# echo "  3. Enable 1Password SSH agent in 1Password app settings"
# echo
