# General XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Rust and Cargo
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
. "$CARGO_HOME/env"

# Fixing paths
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export VIMINIT='source $MYVIMRC'
export MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export PYTHON_HISTORY="$XDG_DATA_HOME/python/history"
export WAKATIME_HOME="$XDG_DATA_HOME/wakatime"
export STEAM_CONFIG_HOME="$XDG_CONFIG_HOME/steam"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export PULSE_COOKIE="$XDG_CONFIG_HOME/pulse/cookie"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export NSS_CONFIG_HOME="$XDG_DATA_HOME/pki"
export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME/nv"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# If I will ever need X11 again
export XAUTHORITY="$XDG_CONFIG_HOME/X11/Xauthority"
