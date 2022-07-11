# Shellcheck doesn't understand zsh specifically, and bash is close enough.
# shellcheck shell=bash

export PATH="${HOME}/bin:${PATH}"

if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# macOS ls needs this set for color output
export CLICOLOR=yes
export EDITOR="e"
# This maps to Solarized colors for ls output
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

if type brew &> /dev/null
then
    asdf_path="$(brew --prefix asdf)/libexec/asdf.sh"
    if [ -f "${asdf_path}" ]; then
        # shellcheck source=/dev/null
        source "${asdf_path}"
    fi
    
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

if type direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi
