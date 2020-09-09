export PATH="${HOME}/bin:/usr/local/MacGPG2/bin:/usr/local/sbin:${PATH}"

# macOS ls needs this set for color output
export CLICOLOR=yes
export EDITOR="e -w"
# This maps to Solarized colors for ls output
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Enable rbenv,pyenv,nodenv
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(nodenv init -)"
