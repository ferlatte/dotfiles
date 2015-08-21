# .bashrc -*- Mode: Shell-script; -*-

# Don't do anything if we are a non-interactive shell.
[ -z "$PS1" ] && return

# Load Bash It early so we can over-ride some of the poor choices.
if [ -d $HOME/.bash_it ]; then
    export BASH_IT=$HOME/.bash_it
    source $BASH_IT/bash_it.sh
fi

# Load the library
[ -f $HOME/.bash_library ] && . $HOME/.bash_library

# Set XTerm and compatibles titlebars
case $TERM in
	xterm*)
		PROMPT_COMMAND='history -a; history -n; echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'
		;;
	*)
		;;
esac

PS1="[\u@\h \w]\\$ "

# Aliases
# Note: never use an alias when a shell script will do.
alias lo='logout'

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

if inpath aws_completer; then
	complete -C aws_completer aws
fi

HISTFILESIZE=10000
HISTSIZE=$HISTFILESIZE
HISTCONTROL=ignoreboth
HISTIGNORE='ls:bg:fg:history'
HISTTIMEFORMAT='%F %T '

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
