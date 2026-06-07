


bindkey -v
autoload -Uz edit-command-line
zle -N edit-command-line
VISUAL=nvim
bindkey '^E' edit-command-line


[[ -o interactive ]] || return





export ZDOTDIR="$HOME/.config/zsh"
export PATH="$HOME/.local/bin:$PATH"
export PATH=/home/anasr/.opencode/bin:$PATH
export BROWSER=brave-browser
export OLLAMA_PLACEHOLDER=ollama





HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=200000
SAVEHIST=200000


setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS


setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE







zstyle ':completion:*' menu no
zstyle ':completion:*' auto-description 'format'


if autoload -Uz compinit 2>/dev/null; then
    compinit
fi


if [[ -f ~/.zsh/fzf-tab/fzf-tab.plugin.zsh ]]; then
    source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
else
    echo "Warning: fzf-tab not found at ~/.zsh/fzf-tab/. Run:"
    echo "git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/fzf-tab"
fi


if [[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=blue,bold'
fi


if [[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi





bindkey '\e^I' autosuggest-accept





eval "$(zoxide init zsh)"

if command -v fzf &> /dev/null; then
  eval "$(fzf --zsh)"
fi





alias grep='grep --color=auto'
alias reload_zsh_config='source ~/.config/zsh/.zshrc'
alias r='reload_zsh_config'
alias cr="clear ; r"
alias clip="wl-copy"
alias audioctl="pavucontrol"
alias rw="sudo systemctl restart iwd"
alias chat="llm -m gemini-2.5-flash-lite"

alias cd='z'
alias a="ff"

alias ls='eza -F --icons --group-directories-first'
alias lsa="eza -lh --total-size"
alias rf="rm -rf ~/.cache/fastfetch/"

alias ae="auto_env"
alias latex_compile="pdflatex -interaction=nonstopmode -halt-on-error -output-directory=build"

alias night="gammastep -O 3000"
alias pdf='brave-browser "$(fd . -e pdf | fzf)"'
alias fonts="fc-list : family"
alias disco="discord --enable-features=UseOzonePlatform --ozone-platform=wayland"



function battery() {
  BATTERY_PERCENT=$(cat /sys/class/power_supply/BAT1/capacity)
  BATTERY_STATUS=$(cat /sys/class/power_supply/BAT1/status)

  echo "Battery Status: $BATTERY_STATUS"
  echo "Battery Percent: $BATTERY_PERCENT %"
}


function new_cargo() {
  if ! command -v cargo &> /dev/null; then
    echo "Error: cargo is not installed" >&2
    return 1
  fi

  if [ -d "$1" ]; then
    echo "Error: Directory '$1' already exists" >&2
    return 1
  fi

  cargo new "$1" && cd "$1" && rm -rf .git && git init -b main && git add . && git commit -m "init"

}

function new_uv() {
  if ! command -v uv &> /dev/null; then
    echo "Error: uv is not installed" >&2
    return 1
  fi

  if [ -z "$1" ]; then
    echo "Usage: new_uv <project_name>" >&2
    return 1
  fi

  if [ -d "$1" ]; then
    echo "Error: Directory '$1' already exists" >&2
    return 1
  fi


  uv init "$1" && cd "$1" || return 1


  uv venv


  cat <<'EOF' > pyrightconfig.json
{
  "venvPath": ".",
  "venv": ".venv"
}
EOF


  rm -rf .git
  git init -b main
  git add .
  git commit -m "init"
}

function new_go() {
  if ! command -v go &> /dev/null; then
    echo "Error: go is not installed" >&2
    return 1
  fi

  if [ -z "$1" ]; then
    echo "Usage: new_go <project_name>" >&2
    return 1
  fi

  if [ -d "$1" ]; then
    echo "Error: Directory '$1' already exists" >&2
    return 1
  fi


  mkdir -p "$1" && cd "$1" || return 1


  go mod init "$1"


  cat <<'EOF' > main.go
package main

import "fmt"

func main() {
	fmt.Println("Hello, World!")
}
EOF


  rm -rf .git
  git init -b main
  git add .
  git commit -m "init"
}


function cpex()
{
    if (( $# == 0 )); then
      echo "Usage: cptype <ext1> [ext2] ..."
      return 1
    fi

    local fd_args=()
    for ext; do
        fd_args+=(-e "$ext")
    done

    fd "${fd_args[@]}" -0 | while IFS= read -r -d '' file; do
        echo "// $file"
        cat "$file"
        echo ""
    done | wl-copy
}

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

ff() {
  z $(fd . -t d | fzf)
}

tn() {
  echo -n "Enter the name of the session > "
  read TMUX_SESSION_NAME
  if tmux has-session -t "$TMUX_SESSION_NAME" 2>/dev/null; then
    tmux attach -t "$TMUX_SESSION_NAME"
  else
    tmux new -s "$TMUX_SESSION_NAME"
  fi
}

ta() {
  local session
  session=$(tmux ls 2>/dev/null | fzf | awk -F: '{print $1}')
  if [ -n "$session" ]; then
    tmux attach -t "$session"
  fi
}

chpwd() {
  ls
}





if [ -z "$TMUX" ]; then
  tmux attach || tmux
fi





export PATH=$PATH:/home/anasr/.spicetify
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=/home/anasr/.local/xonsh-env/xbin:$PATH

source /home/anasr/.config/broot/launcher/bash/br

if [ -f "$HOME/.config/zsh/.zsh_secrets" ]; then
    source "$HOME/.config/zsh/.zsh_secrets"
fi




#




export AI_CMD_PROVIDER='openai'


export AI_CMD_OPENAI_URL='https://api.groq.com/openai/v1/chat/completions'


export AI_CMD_OPENAI_MODEL='llama-3.3-70b-versatile'


if [[ -f ~/.config/zsh/.zsh-ai/ai-cmd.plugin.zsh ]]; then
    source ~/.config/zsh/.zsh-ai/ai-cmd.plugin.zsh
fi


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi





source "$ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme"



export EDITOR="nvim"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh


function download() 
{
  local link=$1
  local file=$2

  if [[ -z $link || -z $file ]]; then
    echo "Usage: download <link> <file_name>" >&2
    return 1
  fi

  wget -c "$link" -O "$file"
}

function smart_download() 
{
  local link=$1
  local file=$2

  if [[ -z $link || -z $file ]]; then
    echo "Usage: smart_download <link> <file_name>" >&2
    return 1
  fi

  curl --fail -C - --speed-limit 1 --speed-time 10 --retry 5 --retry-delay 2 -o "$file" "$link"
}


function hard_cp() 
{
  local src="${1%/}"
  local dst="${2%/}"

  if [[ -z $src || -z $dst ]]; then
    echo "Usage: hard_cp <source> <destination_dir>" >&2
    return 1
  fi

  if [[ ! -d $dst ]]; then
    echo "Error: destination must be an existing directory" >&2
    return 1
  fi

  rsync -ah --progress "$src" "$dst"

  echo "Flushing write cache to device... (Please wait, this may take some time)"
  sync 

  local dst_path="$dst/$(basename "$src")"

  local hash_tool="md5sum"
  if command -v xxhsum &>/dev/null; then
    hash_tool="xxhsum"
  elif command -v xxsum &>/dev/null; then
    hash_tool="xxsum"
  elif command -v sha1sum &>/dev/null; then
    hash_tool="sha1sum"
  fi

  echo "Verifying file integrity using $hash_tool..."

  if [[ -f $src ]]; then
    local src_hash=$($hash_tool "$src" | cut -d' ' -f1)
    local dst_hash

    if ! dst_hash=$(dd if="$dst_path" iflag=direct 2>/dev/null | $hash_tool | cut -d' ' -f1); then
      dst_hash=$($hash_tool "$dst_path" | cut -d' ' -f1)
    fi

    if [[ $src_hash == $dst_hash ]]; then
      echo "Verification passed. Safe to unplug."
    else
      echo "Verification failed! Data corruption detected." >&2
      return 1
    fi

  elif [[ -d $src ]]; then
    local src_hash=$(cd "$src" && find . -type f -exec "$hash_tool" {} + 2>/dev/null | sort | "$hash_tool" | cut -d' ' -f1)
    local dst_hash=$(cd "$dst_path" && find . -type f -exec "$hash_tool" {} + 2>/dev/null | sort | "$hash_tool" | cut -d' ' -f1)

    if [[ $src_hash == $dst_hash ]]; then
      echo "Verification passed. Safe to unplug."
    else
      echo "Verification failed! Data corruption detected." >&2
      return 1
    fi
  fi
}
