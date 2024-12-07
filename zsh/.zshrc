# Shellcheck doesn't understand zsh specifically, and bash is close enough.
# shellcheck shell=bash

export PATH="${HOME}/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/Applications/Docker.app/Contents/Resources/bin:${PATH}"

if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# macOS ls needs this set for color output
export CLICOLOR=yes
export EDITOR=code
# This maps to Solarized colors for ls output
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

SSH_AUTH_SOCK=$(ssh -G localhost | grep identityagent | cut -d ' ' -f 2)
export SSH_AUTH_SOCK

if type brew &> /dev/null
then
    asdf_path="$(brew --prefix asdf)/libexec/asdf.sh"
    if [ -f "${asdf_path}" ]; then
        # shellcheck source=/dev/null
        source "${asdf_path}"
    fi
    # This little bit of syntax adds an element (the brew site-functions, in this case) before
    # the first element of the fpath array. This is how you do an unshift operation in zsh.
    # shellcheck disable=SC2034 # fpath is used by zsh and shellcheck doesn't know this.
    fpath[1,0]="$(brew --prefix)/share/zsh/site-functions"
    autoload -Uz compinit
    # compinit -i ignores fpath directories with insecure permissions. This is really
    # common on multi-users macOS systems, and therefor annoying.
    compinit -i
fi

if type direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi
