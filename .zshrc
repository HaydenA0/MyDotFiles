# bindkey -v
# rm -rf ~/Downloads/
# rm -rf ~/Desktop/
# (cat ~/.cache/wal/sequences &)
alias fzf="sk"



setopt AUTO_CD
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR="nvim"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"



zinit ice lucid wait'0' turbo


# edit in nvim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line




# My condfig this time
#TODO : Check this math
autoload -Uz promptinit
promptinit

set_prompt() {
    local cols=$(tput cols)           # get terminal width
    local dir="%~"                    # directory string
    local len=${#${(%)dir}}           # length of the directory string
    local padding=$(( (cols - len) / 2 ))  # calculate spaces for centering
    PS1="%F{blue}$(printf '%*s' $padding '')${dir}%f
%F{red}zsh ::%f "
}

precmd_functions+=(set_prompt)




# Sorry
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# zinit ice depth=1 ; zinit light romkatv/powerlevel10k

# zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light marlonrichert/zsh-autocomplete
zinit light junegunn/fzf





# alias ls='exa -liF --no-user --no-time --group-directories-first'
alias ls='exa -F --icons --color=never --group-directories-first'
alias lsa="exa -lh --total-size"



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
   selected=$(fd -t d --exclude '__pycache__' --exclude '.git' . ~ | fzf)

  # The rest of the logic remains the same.
  if [[ -n "$selected" ]]; then
    if [[ -d "$selected" ]]; then
      z -- "$selected"
    elif [[ -f "$selected" ]]; then
      nvim -- "$selected"
    fi
  fi
}
hf() {
  local selected
   selected=$(fd  -t d --exclude '__pycache__' --exclude '.git' . . | fzf)

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
alias i="hf"
alias zi="\zi"

autoload -U colors && colors

alias reload="source ~/.zshrc"
# source <(fzf --zsh)



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
# chpwd_functions+=("auto_env")

alias -s /="cd"




# function zle-keymap-select {
#   if [[ $KEYMAP == vicmd ]]; then
#     RPS1="< NORMAL >"
#   else
#     RPS1="> INSERT >"
#   fi
#   zle reset-prompt
# }
# zle -N zle-keymap-select



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


alias zshc="nvim ~/.zshrc"
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
pdf() {
    pdf=$(fd -e pdf . | fzf) && setsid zathura "$pdf" >/dev/null 2>&1 &
}





typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

if [[ -z "$TMUX" ]]; then
    tmux new-session -A -s 1
fi

cpw() {
    pwd | wl-copy
}
alias clipp="wl-copy"
note() {
    local timestamp=$(date +%Y-%m-%d)
    local filename="$timestamp-${1// /-}.typ"
    nvim "$HOME/personal_vault/00-inbox/$filename"
}


pro() {
  cd "$(fd . ~/dev/Projects  -t d --max-depth 1 --exclude '.*' --exclude '__*' | fzf)"
}
bindkey -r '\ec'   # Alt+C
bindkey -r '\C-t'  # Ctrl+T

alias audioctl="pavucontrol"



alias calc="numi-cli"


# Create a custom clear-screen function
function clear_screen_x() {
  clear -x
  zle reset-prompt
}
zle -N clear_screen_x
bindkey '^L' clear_screen_x




