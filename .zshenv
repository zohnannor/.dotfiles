export ZDOTDIR="$HOME/.config/zsh"

# Source the global profile if needed (though session login should handle it)
if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi
