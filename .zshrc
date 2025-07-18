HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt localoptions rmstarsilent

autoload -U compinit colors && colors && compinit

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%B%F{blue}git:(%f%F{red}%b%f%F{blue})%f%%b '

zstyle ':completion:*' list-colors 'ma=1;30;47' '=(#b)*=1;34'
zstyle ':completion:*' menu select

setopt prompt_subst
PROMPT='%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%} ${vcs_info_msg_0_}'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dir='ls --color=auto'
