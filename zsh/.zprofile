# Shellcheck doesn't understand zsh specifically, and bash is close enough.
# shellcheck shell=bash

# This runs once per login shell, and what it exports is inherited by every
# shell underneath, so setup that costs a subprocess belongs here rather than
# in .zshrc (which runs for every interactive shell, nested ones included).

if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

SSH_AUTH_SOCK="$(ssh -G localhost | grep identityagent | sed -e "s/^identityagent //")"
export SSH_AUTH_SOCK
