# .bashrc -*- Mode: Shell-script; -*-
# shellcheck shell=bash

# Don't do anything if we are a non-interactive shell.
[[ -z "$PS1" ]] && return

# Load Bash It early so we can over-ride some of the poor choices.
if [[ -d $HOME/.bash_it ]]; then
    export BASH_IT=$HOME/.bash_it
    # shellcheck source=/dev/null
    source "$BASH_IT"/bash_it.sh
fi

# Load the library
# shellcheck disable=SC1091
# shellcheck source=.bash_library
[[ -f $HOME/.bash_library ]] && . "$HOME"/.bash_library

# Set XTerm and compatibles titlebars
case $TERM in
	xterm*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'
		;;
	*)
		;;
esac

PS1="[\\u@\\h \\w]\\$ "

# Aliases
# Note: never use an alias when a shell script will do.
alias lo=logout
alias vi='e --tty'
alias vim='e --tty'

# Shell Options

# Append to the history file instead of destroying it every time.
shopt -s histappend

# Attempt to perform hostname completion when a word containing an @ is being
# completed.
shopt -s hostcomplete

# Save multiline shell commands as one line in the history.
shopt -s cmdhist

# Do not attempt to search the PATH for possible completions when completion is
# attempted on an empty line.
shopt -s no_empty_cmd_completion

# Turn on programmable completion
shopt -s progcomp

HISTFILESIZE=10000
HISTSIZE=$HISTFILESIZE
HISTCONTROL=ignoreboth
HISTIGNORE='ls:bg:fg:history'
HISTTIMEFORMAT='%F %T '

# Nodeenv
inpath nodenv && eval "$(nodenv init -)"

# Finally, source a .bashrc.local for site specific crap.
# shellcheck source=/dev/null
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
