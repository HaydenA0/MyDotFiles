


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
alias bsize="du -sbh"
alias codetype="cloc"



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

    read memtotal_kb memfree_kb buffers_kb cached_kb <<< "$(awk '
        /^MemTotal:/ { T=$2 }
        /^MemFree:/  { F=$2 }
        /^Buffers:/  { B=$2 }
        /^Cached:/   { C=$2 }
        END { print T, F, B, C }
    ' /proc/meminfo)"
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



delete() {
  mkdir -p ~/.trash
  for f in "$@"; do
    mv "$f" ~/.trash
    echo "Moved $f to ~/.trash"
  done
}

cpex()
{
  local mode="ext" dirs=() files=() exts=() tree_depth= args=()

  local expect_depth=0
  for arg in "$@"; do
    if [[ $expect_depth == 1 ]]; then
      if [[ $arg =~ ^[0-9]+$ ]]; then
        tree_depth=$arg
      else
        args+=("$arg")
      fi
      expect_depth=0
    elif [[ $arg == "-t" ]]; then
      tree_depth=4
      expect_depth=1
    else
      args+=("$arg")
    fi
  done

  set -- "${args[@]}"

  if (( $# == 0 )); then
    echo "Usage: cpex [-t [n]] <ext1> [ext2] ..." >&2
    echo "       cpex [-t [n]] -d <dir> ... -e <ext1> ..." >&2
    echo "       cpex [-t [n]] -f <file> ... -e <ext1> ..." >&2
    return 1
  fi

  if [[ $1 == "-d" ]]; then
    mode="dir"
    shift
    while (( $# > 0 )) && [[ $1 != "-e" ]]; do dirs+=("$1"); shift; done
    [[ $1 == "-e" ]] && shift
    while (( $# > 0 )); do exts+=("$1"); shift; done
  elif [[ $1 == "-f" ]]; then
    mode="file"
    shift
    while (( $# > 0 )) && [[ $1 != "-e" ]]; do files+=("$1"); shift; done
    [[ $1 == "-e" ]] && shift
    while (( $# > 0 )); do exts+=("$1"); shift; done
  else
    exts=("$@")
  fi

  local fd_args=(--type f)
  for ext in "${exts[@]}"; do fd_args+=(-e "$ext"); done

  {
    if [[ -n $tree_depth ]]; then
      tree -a -L "$tree_depth"
      echo ""
    fi
    if [[ $mode == "ext" ]]; then
      fd "${fd_args[@]}" -0
    elif [[ $mode == "dir" ]]; then
      for dir in "${dirs[@]}"; do
        fd "${fd_args[@]}" . "$dir" -0
      done
    elif [[ $mode == "file" ]]; then
      for f in "${files[@]}"; do printf '%s\0' "$f"; done
      if (( ${#exts[@]} > 0 )); then
        fd "${fd_args[@]}" -0
      fi
    fi
  } | while IFS= read -r -d '' file; do
    echo "// $file"
    cat "$file"
    echo ""
  done | wl-copy
}




echo "≽^•⩊•^≼"


myzip()
{
  local -A ext_map extract_cmds create_cmds list_cmds
  ext_map=(
    .zip      zip
    .7z       7z
    .tar.gz   targz
    .tgz      targz
    .tar.bz2  tarbz2
    .tbz2     tarbz2
    .tar.xz   tarxz
    .txz      tarxz
    .tar.zst  tarzst
    .tzst     tarzst
  )
  extract_cmds=(
    zip     "unzip \"\$file\" -d \"\$dir\""
    7z      "7z x \"\$file\" -o\"\$dir\""
    targz   "mkdir -p \"\$dir\" && tar -xzf \"\$file\" -C \"\$dir\""
    tarbz2  "mkdir -p \"\$dir\" && tar -xjf \"\$file\" -C \"\$dir\""
    tarxz   "mkdir -p \"\$dir\" && tar -xJf \"\$file\" -C \"\$dir\""
    tarzst  "mkdir -p \"\$dir\" && tar --zstd -xf \"\$file\" -C \"\$dir\""
  )
  create_cmds=(
    zip     "zip \"\$output\" \$@"
    7z      "7z a \"\$output\" \$@"
    targz   "tar -czvf \"\$output\" \$@"
    tarbz2  "tar -cjvf \"\$output\" \$@"
    tarxz   "tar -cJvf \"\$output\" \$@"
    tarzst  "tar --zstd -cvf \"\$output\" \$@"
  )
  list_cmds=(
    zip     "unzip -l \"\$file\""
    7z      "7z l \"\$file\""
    targz   "tar -tzf \"\$file\""
    tarbz2  "tar -tjf \"\$file\""
    tarxz   "tar -tJf \"\$file\""
    tarzst  "tar --zstd -tf \"\$file\""
  )

  local file ext type dir output e

  __myzip_check_name()
  {
    if [[ ! $1 =~ ^[a-zA-Z0-9._/-]+$ ]]; then
      echo "Error: filename contains spaces or special characters: $1" >&2
      return 1
    fi
  }

  __myzip_detect()
  {
    for e in ${(k)ext_map}; do
      if [[ $1 == *$e ]]; then ext=$e; type=$ext_map[$e]; return 0; fi
    done
    echo "Error: unsupported archive: $1" >&2
    return 1
  }

  if [[ $1 == "-l" ]]; then
    file=$2
    __myzip_check_name "$file" || return 1
    __myzip_detect "$file" || return 1
    eval ${list_cmds[$type]}
  elif [[ $1 == "-o" ]]; then
    output=$2
    __myzip_check_name "$output" || return 1
    __myzip_detect "$output" || { echo "Error: unsupported output extension" >&2; return 1; }
    shift 2
    if [[ $1 != "-i" ]]; then echo "Error: expected -i flag after output file" >&2; return 1; fi
    shift
    for f in "$@"; do __myzip_check_name "$f" || return 1; done
    eval ${create_cmds[$type]}
  elif [[ $1 == "-"* ]]; then
    echo "Usage: myzip archive.ext           (extract)"
    echo "       myzip -o out.ext -i f1...   (create)"
    echo "       myzip -l archive.ext        (list)"
    return 1
  else
    file=$1
    __myzip_check_name "$file" || return 1
    __myzip_detect "$file" || return 1
    dir="${file%$ext}"
    mkdir -p "$dir" && eval ${extract_cmds[$type]}
  fi
}
export _JAVA_AWT_WM_NONREPARENTING=1
