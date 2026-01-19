# Set ZDOTDIR to use .config/zsh
export ZDOTDIR="$HOME/.config/zsh"

# Source the main zshrc from ZDOTDIR
if [[ -f "$ZDOTDIR/.zshrc" ]]; then
  source "$ZDOTDIR/.zshrc"
fi
