# ==========================================
# General Settings & Key Bindings
# ==========================================
bindkey -v                      # Use Vi-mode
[[ -o interactive ]] || return  # Ensure non-interactive shells return

# ==========================================
# Environment Variables
# ==========================================
export ZDOTDIR="$HOME/.config/zsh"
export PATH="$HOME/.local/bin:$PATH"
export PATH=/home/anasr/.opencode/bin:$PATH # opencode tool path
export BROWSER=zen-browser

# ==========================================
# History Configuration
# ==========================================
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=200000
SAVEHIST=200000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# ==========================================
# Completion & Zstyle
# ==========================================
zstyle ':completion:*' menu select
zstyle ':completion:*' auto-description 'format'

if autoload -Uz compinit 2>/dev/null; then
    compinit
fi

# ==========================================
# Plugins
# ==========================================
# Syntax Highlighting
if [[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=blue,bold'
fi

# Autosuggestions
if [[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi

# Autosuggestion Keybindings
bindkey '^I' autosuggest-accept
bindkey '\e^I' expand-or-complete

# ==========================================
# Prompt & Shell Tools
# ==========================================
eval "$(starship init zsh)"     # Prompt
(cat ~/.cache/wal/sequences &)  # Pywal color sequences
eval "$(zoxide init zsh)"       # Smart directory jump

# ==========================================
# Aliases
# ==========================================
# System/Utility
alias grep='grep --color=auto'
alias reload_zsh_config='source ~/.config/zsh/.zshrc'
alias r='reload_zsh_config'
alias cr="clear ; r"
alias clip="wl-copy"
alias audioctl="pavucontrol"
alias rw="sudo systemctl restart iwd"
alias chat="llm -m gemini-2.5-flash-lite"

# Directory & Navigation
alias cd='z'
alias a="ff"

# File Management
alias ls='eza -lF --icons --group-directories-first'
alias lsa="eza -lh --total-size"
alias cat="bat"
alias rf="rm -rf ~/.cache/fastfetch/"

# Development
alias ae="auto_env"
alias latex_compile="pdflatex -interaction=nonstopmode -halt-on-error -output-directory=build"

# ==========================================
# Functions
# ==========================================
# Definitions
function define() {
  notify-send -t 0 "$(python ~/dev/projects/definition/main.py "$1")"
}

# Python Virtual Environments
function mkvenv() {
  uv venv
  source .venv/bin/activate
  echo "Venv Created"
}
auto_env() {
  if [[ -n "$VIRTUAL_ENV" && ! -d ".venv" ]]; then
    deactivate
    echo "Deactivated Python venv"
  fi
  if [[ -d ".venv" && -z "$VIRTUAL_ENV" ]]; then
    source .venv/bin/activate
    echo "Activated venv"
  fi
}

# Fast directory jump helper
ff() {
  z $(fd . -t d | fzf)
}

# ==========================================
# Tmux Configuration
# ==========================================
# Create/attach to named session
tn() {
  echo -n "Enter the name of the session > "
  read TMUX_SESSION_NAME
  if tmux has-session -t "$TMUX_SESSION_NAME" 2>/dev/null; then
    tmux attach -t "$TMUX_SESSION_NAME"
  else
    tmux new -s "$TMUX_SESSION_NAME"
  fi
}

# Select and attach to session
ta() {
  local session
  session=$(tmux ls 2>/dev/null | fzf | awk -F: '{print $1}')
  if [ -n "$session" ]; then
    tmux attach -t "$session"
  fi
}

# Auto-attach on login
if [ -z "$TMUX" ]; then
  tmux attach || tmux
fi
