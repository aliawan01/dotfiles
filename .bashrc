alias ls='ls --color=auto'
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias lsa='ls -lah'

function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"
}

BOLD_RED="\[\033[1;31m\]"
BOLD_GREEN="\[\033[1;32m\]"
CYAN="\[\033[36m\]"
BOLD_BLUE="\[\033[1;34m\]"
RED="\[\033[31m\]"
BLUE="\[\033[34m\]"
YELLOW="\[\033[33m\]"
RESET="\[\033[0m\]"

function set_bash_prompt() {
  local last_exit_code=$?
  local arrow_color="${BOLD_GREEN}"

  if [ $last_exit_code -ne 0 ]; then
    arrow_color="${BOLD_RED}"
  fi

  local git_status=""
  local extra_space_for_git_status=""

  if git rev-parse --is-inside-work-tree &> /dev/null; then
    local branch=$(parse_git_branch)
    extra_space_for_git_status=" "

    git_status="${BOLD_BLUE}git:(${RED}${branch}${BLUE})"
  fi

  PS1="${arrow_color}➜  ${CYAN}\W ${git_status}${RESET}${extra_space_for_git_status}"
}

PROMPT_COMMAND=set_bash_prompt
