





bindkey -v
[[ -o interactive ]] || return
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' auto-description 'format'
bindkey "${terminfo[kcuu1]}" history-beginning-search-backward
bindkey "${terminfo[kcud1]}" history-beginning-search-forward
if [[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=blue,bold'

fi
if [[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi


export ZDOTDIR="$HOME/.config/zsh"
export PATH="$HOME/.local/bin:$PATH"

PS1='%~
$ '

(cat ~/.cache/wal/sequences &)

eval "$(zoxide init zsh)"


alias grep='grep --color=auto'
alias reload_zsh_config='source ~/.config/zsh/.zshrc'
alias r='reload_zsh_config'
alias cd='z'
alias cr="clear ; r"
alias ls='exa -lF --icons --group-directories-first'
alias lsa="exa -lh --total-size"
alias cat="bat"
alias audioctl="pavucontrol"
alias a="ff"
alias rf="rm -rf ~/.cache/fastfetch/"
alias ae="auto_env"


function mkvenv() {
  python -m venv .venv
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








