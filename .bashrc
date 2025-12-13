# constants ?
PDF_READER=mupdf
export PATH=$PATH:~/.cargo/bin/
COLOR_RED='\033[0;31m'
COLOR_RESET='\033[0m'

[[ $- != *i* ]] && return
# river
if [ -z "$WAYLAND_DISPLAY" ] && [ $(tty) = "/dev/tty1" ]; then
  exec river
fi
# cmd line
PS1="${COLOR_RED} \w\n${COLOR_RESET} $ "

# evaluation
eval "$(zoxide init bash)"




# my functions
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
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias reload_bash_config='source ~/.bashrc'
alias r='reload_bash_config'
alias cd='z'
alias cr="clear ; r"
alias ls='exa -lF --icons --color=never --group-directories-first'
alias lsa="exa -lh --total-size"
alias cat="bat"
alias bashc="nvim ~/.bashrc"
alias audioctl="pavucontrol"
alias a="ff"
