# Shellcheck doesn't understand zsh specifically, and bash is close enough.
# shellcheck shell=bash

export PATH="${HOME}/bin:${PATH}"

if [ -x /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi

# macOS ls needs this set for color output
export CLICOLOR=yes
export EDITOR="e"
# This maps to Solarized colors for ls output
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# shellcheck source=/dev/null
source "$(brew --prefix asdf)/asdf.sh"

eval "$(direnv hook zsh)"
