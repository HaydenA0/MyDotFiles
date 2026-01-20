export ZDOTDIR="$HOME/.config/zsh"
export PATH="$HOME/.local/bin:$PATH"

(cat ~/.cache/wal/sequences &)
PS1='%~
$ '


eval "$(zoxide init zsh)"




pdf() {
  $PDF_READER -I "$(fd -e pdf . | fzf)" 
}
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
tman() {
  ~/scripts/tman.sh
}
python_calc() {
  ~/scripts/python_calc.sh
}

run() {
  ~/scripts/run.sh
}
run_auto() {
  ~/scripts/run_auto.sh
}
ff() {
  z $(fd . -t d | fzf)
}


# tmux
# if [[ -z "$TMUX" ]]; then
#     tmux new-session -A -s 1
# fi

# aliases
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

