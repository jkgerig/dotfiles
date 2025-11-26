# 30-op.zsh - 1Password CLI integration

# Helper to load secrets on demand
load_secrets() {
    # Example: export ANTHROPIC_API_KEY="$(op read 'op://Personal/Anthropic/credential')"
    echo "Define secrets in this function or use 'op run --env-file=.env -- command'"
}

# Set default 1Password account based on profile
if [[ "$DOTFILES_PROFILE" == "work" ]]; then
    export OP_ACCOUNT="work.1password.com"
fi
