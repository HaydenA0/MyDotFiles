bindkey -v
rm -rf ~/Downloads/
rm -rf ~/Desktop/
(cat ~/.cache/wal/sequences &)
fastfetch


MARGIN=150
NO_MARGIN=20
# if [[ -z "$NVIM" ]]; then
#   kitty @ set-spacing margin=$MARGIN 2>/dev/null
# fi
# nvim() {
#   kitty @ set-spacing margin=$NO_MARGIN
#   command nvim "$@"
#   kitty @ set-spacing margin=$MARGIN
# }


setopt AUTO_CD
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"



zinit ice lucid wait'0' turbo
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
zinit ice depth=1 ; zinit light romkatv/powerlevel10k

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light marlonrichert/zsh-autocomplete
zinit light junegunn/fzf





# alias ls='exa -l --group-directories-first --icons'
alias ls='exa -l --no-user --no-time --group-directories-first --icons'
alias lsa="exa -lh --total-size"

dup() {
	kitten @ launch --type=tab --keep-focus zsh -lc "\cd \"$(zoxide query $(pwd))\"; exec zsh"
}

bright() {
  if [ $# -eq 0 ]; then
    echo "Usage: bright <percent>"
    return 1
  fi
  brightnessctl set "$1"% 
}

export PATH="$HOME/ghostty:$PATH"

vol() {
  if [ $# -eq 0 ]; then
    echo "Usage: vol <percent>"
    return 1
  fi
  pamixer --set-volume "$1"
}


ff() {
  local selected

  selected=$(fd . ./ -t f --min-depth 1 --exclude '.*' --exclude '__*' | fzf)

  if [[ -n "$selected" ]]; then
    if [[ -d "$selected" ]]; then
      cd -- "$selected"
    elif [[ -f "$selected" ]]; then
      nvim -- "$selected"
    fi
  fi
}

cf() {
  local selected
  # `fd` is much faster and the syntax is cleaner.
  # It finds both files (-t f) and directories (-t d) by default.
  # It ignores hidden files and .gitignore by default.
  # We add --exclude to replicate your original logic.
   selected=$(fd -t d --exclude '__pycache__' --exclude '.git' . ~ | fzf)
  # selected=$(find -type d | fzf)

  # The rest of the logic remains the same.
  if [[ -n "$selected" ]]; then
    if [[ -d "$selected" ]]; then
      z -- "$selected"
    elif [[ -f "$selected" ]]; then
      nvim -- "$selected"
    fi
  fi
}
alias a="cf"
alias q="ff"

autoload -U colors && colors

alias reload="source ~/.zshrc"
source <(fzf --zsh)



alias c="clear"
unalias cd 2>/dev/null
cd() {
    if [ $# -eq 0 ]; then
        builtin cd ~ && ls
        return
    fi

    # Use z to jump to the directory
    z "$@" && ls
}

alias tree="eza --tree"
function mkvenv() {
  python -m venv .venv
  source .venv/bin/activate
  echo "Virtual environment '.venv' created and activated."
}


#eval the zis    
eval "$(zoxide init zsh)"




auto_env() {
  # Deactivate Python venv if leaving a directory with no .venv
  if [[ -n "$VIRTUAL_ENV" && ! -d ".venv" ]]; then
    deactivate
    echo " Deactivated Python venv."
  fi

  # Activate .venv if it exists and is not active
  if [[ -d ".venv" && -z "$VIRTUAL_ENV" ]]; then
    echo " Activating .venv..."
    source .venv/bin/activate
  fi
}

# Register function to run on directory change
chpwd_functions+=("auto_env")

alias -s /="cd"
    


  
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    RPS1="< NORMAL >"
  else
    RPS1="> INSERT >"
  fi
  zle reset-prompt
}
zle -N zle-keymap-select



# -----------------------------------------------------------------------------
# File Copy/Paste for Wayland (Hyprland)
#
# Usage:
#   copy <file1> <folder2> ...   # Copies files/folders to the clipboard
#   past                          # Pastes files/folders from clipboard to CWD
# -----------------------------------------------------------------------------

# Function to copy file/folder paths to the Wayland clipboard
#
 
# Function to copy file/folder paths to the Wayland clipboard (IMPROVED & MORE ROBUST)


alias cr="c && reload"

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt append_history
setopt share_history


alias zshc="nvim .zshrc"
alias s="sudo"
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
bindkey '^I' autosuggest-accept
bindkey '^[[Z' complete-word     
bindkey "$terminfo[kcbt]" menu-complete

alias tim="tty-clock -x -s -c"
alias class="hyprctl clients"
alias jn="jupytext --to notebook"



tman() {
    local memtotal_kb memfree_kb buffers_kb cached_kb used_gb

    echo "APP    TOTAL MEMORY (MB)"

    ps -eo comm,rss --no-headers | \
    awk '
      { app[$1] += $2/1024 }
      END {
        for (n in app)
          if (app[n] > 0) printf "%-8s %.2f\n", n, app[n]
      }' | sort -k2 -n

    echo ""

    # Read all required values from /proc/meminfo in a single awk call
    # The 'read' command assigns the space-separated output to variables
    read memtotal_kb memfree_kb buffers_kb cached_kb <<< "$(awk '
        /^MemTotal:/ { T=$2 }
        /^MemFree:/  { F=$2 }
        /^Buffers:/  { B=$2 }
        /^Cached:/   { C=$2 }
        END { print T, F, B, C }
    ' /proc/meminfo)"

    # The calculation remains the same
    used_gb=$(awk \
      -v T="$memtotal_kb" -v F="$memfree_kb" -v B="$buffers_kb" -v C="$cached_kb" \
      'BEGIN {
         used_kb = T - F - B - C
         used_gb  = used_kb/1024/1024
         printf "%d", used_gb + 0.5
      }'
    )

    echo "app mem"
    echo "-------"
    echo "MEM USAGE : $used_gb/24.0 GB"
}



export PATH=$PATH:/home/anasr/.spicetify
alias clear_fastfetch="rm -rf $HOME/.cache/fastfetch/ ; cr"
pdf_slect() {
  pdf=$(find . -name "*.pdf" -print0 | fzf --read0) && setsid zathura "$pdf" >/dev/null 2>&1 &

}


alias note="nvim $HOME/personal_vault/notes/"
