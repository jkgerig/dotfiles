# 30-op.zsh - 1Password CLI integration

# Helper to load secrets on demand
load_secrets() {
    # Example: export ANTHROPIC_API_KEY="$(op read 'op://Personal/Anthropic/credential')"
    echo "Define secrets in this function or use 'op run --env-file=.env -- command'"
}
