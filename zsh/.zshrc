# Shellcheck doesn't understand zsh specifically, and bash is close enough.
# shellcheck shell=bash

export PATH="${HOME}/bin:/usr/local/MacGPG2/bin:/usr/local/sbin:${PATH}"

# macOS ls needs this set for color output
export CLICOLOR=yes
export EDITOR="e"
# This maps to Solarized colors for ls output
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
