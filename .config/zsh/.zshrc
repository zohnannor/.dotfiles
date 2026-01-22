# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/*
# Custom plugins may be added to $ZSH/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    rust
    command-not-found
    colored-man-pages
    # common-aliases
    safe-paste
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-abbr
)

# User configuration

fetch_os() { sed -nE 's/PRETTY_NAME="(.+)"/\1/p' /etc/os-release }

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim';
elif [[ $(fetch_os distro) = "Arch"* ]]; then
  export EDITOR='code';
else
  export EDITOR='nvim';
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
# ctrl+<- | ctrl+->
bindkey  "^[[1;5D" backward-word
bindkey  "^[[1;5C" forward-word

cls() { printf '\x1b[H\x1b[2J\x1b[3J'; zle redisplay; }
zle -N cls
bindkey  "^L" cls

export TERM=xterm-256color

# vscode shell integration
# typeset -g POWERLEVEL9K_TERM_SHELL_INTEGRATION=true

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#aaaaff,bold,underline"

# default prompt
PS1="%{%F{red}%}%n%{%f%}@%{%F{blue}%}%m %{%F{yellow}%}%~ %{$%f%}%% "

if [[ $(fetch_os distro) = "distro: Arch"* ]] && [ -z $DISPLAY ]; then
  export DISPLAY="$(tail -1 /etc/resolv.conf | cut -d' ' -f2):0"
fi

fpath+=~/.zfunc

# Lines configured by zsh-newuser-install
HISTFILE=~/.local/share/histfile
HISTSIZE=10000
SAVEHIST=10000
setopt beep extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename $ZDOTDIR/.zshrc
autoload -Uz compinit
compinit -u
# End of lines added by compinstall

################################################################################

case $(fetch_os distro) in
  "distro: Arch"*)
    xset r rate 300 50
    ;;
esac

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
alias zshrc="$EDITOR $ZDOTDIR/.zshrc"
alias ca=cargo
alias py=python3
alias ls=exa
alias G='| rg'
alias pacman="sudo pacman"
alias exa='exa -lFh@TL 1 --icons --color-scale --group-directories-first --git'
alias exap='exa "$PWD" -lFh@TL 1 --icons --color-scale --group-directories-first --git'
export BAT_PAGER='less --header=3 --LONG-PROMPT --no-number-headers --status-column -j.5'

rgf() {
  local query="${1:-}"
  local initial_cmd="rg --line-number --color=always --smart-case"

  # Get selection from fzf
  # Use --expect to capture which key was used to exit fzf
  local out
  out=$(fzf --ansi \
        --disabled \
        --query "$query" \
        --bind "change:reload:$initial_cmd {q} || true" \
        --expect=ctrl-v,alt-enter \
        --delimiter : \
        --prompt "/.*/ " \
        --header="Enter: bat; Ctrl+V: VS Code: Alt+Enter: Neovim" \
        --preview 'bat --color=always --highlight-line {2} {1}' \
        --preview-window 'right,88,border-left' < /dev/tty)

  # Clear the line and redraw prompt to fix the "new line" issue
  zle reset-prompt

  # Extract key pressed and selection
  local key=$(head -1 <<< "$out")
  local selection=$(sed '1d' <<< "$out")

  if [[ -n "$selection" ]]; then
    local file=$(echo "$selection" | cut -d: -f1)
    local line=$(echo "$selection" | cut -d: -f2)

    case "$key" in
      ctrl-v) code -g "$file:$line" ;;
      alt-enter) nvim "$file" +$line ;;
      *) BAT_PAGER="${BAT_PAGER:-} +${line}" bat "$file" --highlight-line=${line} ;;
    esac
  fi
}
zle -N rgf
bindkey "^F" rgf

export PATH=$PATH:/opt/bin
export PATH=$PATH:/usr/bin

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

ZSH_DISABLE_COMPFIX="true"
function ipsql() {
    psql "$@" || { pg_ctl -D $PREFIX/var/lib/postgresql restart && psql "$@" }
}
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Fuzzy history search
fh() {
    history_command=$(fc -nrl 1 | awk '!x[$0]++' | fzf --scheme=history)
    LBUFFER=${history_command}${LBUFFER}
    zle reset-prompt; zle redisplay
}
zle -N fh
bindkey "^R" fh

# Paru search - outputs installation command for editing
parus() {
    local selected
    selected=$(paru -Sql | fzf --multi --preview 'paru -Si {}' --layout=reverse)
    if [ -n "$selected" ]; then
        local packages=$(echo "$selected" | tr '\n' ' ' | sed 's/ $//')
        print -z "paru -S $packages --assume-installed cargo"
    fi
}

# Paru remove - outputs removal command for editing
parur() {
    local selected
    selected=$(expac '%e %N' | awk '{print NF,$0}' | sort -n -k1 | cut -d" " -f2 | fzf --multi --preview 'paru -Qi {}' --layout=reverse)
    if [ -n "$selected" ]; then
        local packages=$(echo "$selected" | tr '\n' ' ' | sed 's/ $//')
        print -z "paru -Rnsd $packages"
    fi
}

# dotfiles repo command
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

function "btw,"(){print '\033[38;2;23;147;209m
                 I use
                   ▄
                  ▟█▙
                 ▟███▙
                ▟█████▙
               ▟███████▙
              ▂▔▀▜██████▙
             ▟██▅▂▝▜█████▙
            ▟█████████████▙
           ▟███████████████▙
          ▟█████████████████▙
         ▟███████████████████▙
        ▟█████████▛▀▀▜████████▙
       ▟████████▛      ▜███████▙
      ▟█████████        ████████▙
     ▟██████████        █████▆▅▄▃▂
    ▟██████████▛        ▜█████████▙
   ▟██████▀▀▀              ▀▀██████▙
  ▟███▀▘                       ▝▀███▙
 ▟▛▀                               ▀▜▙' }
