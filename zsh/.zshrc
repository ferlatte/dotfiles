# Shellcheck doesn't understand zsh specifically, and bash is close enough.
# shellcheck shell=bash

# shellcheck disable=SC2034 # path is zsh's tied array for PATH; shellcheck doesn't know this.
typeset -U path PATH

export PATH="${HOME}/bin:/Applications/OrbStack.app/Contents/MacOS/xbin:/Applications/OrbStack.app/Contents/MacOS/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:${PATH}"

# macOS ls needs this set for color output
export CLICOLOR=yes
export EDITOR="code --wait"
# This maps to Solarized colors for ls output
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

if type brew &> /dev/null
then
    export ASDF_GOLANG_MOD_VERSION_ENABLED=true
    export ASDF_DATA_DIR="$HOME/.asdf"
    export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
    # This little bit of syntax adds an element (the brew site-functions, in this case) before
    # the first element of the fpath array. This is how you do an unshift operation in zsh.
    # HOMEBREW_PREFIX comes from the shellenv eval in .zprofile; the fallback is
    # for the odd shell that never ran it.
    # shellcheck disable=SC2034 # fpath is used by zsh and shellcheck doesn't know this.
    fpath[1,0]="${HOMEBREW_PREFIX:-$(brew --prefix)}/share/zsh/site-functions"
    autoload -Uz compinit
    # compinit -i ignores fpath directories with insecure permissions. This is really
    # common on multi-users macOS systems, and therefor annoying.
    compinit -i
fi

if type direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

if type gcloud &> /dev/null; then
    # This enables gcloud to use NumPy if you install it.
    export CLOUDSDK_PYTHON_SITEPACKAGES=1
fi

if [[ -f ~/.zshrc.local ]]; then
    # shellcheck source=/dev/null
    source ~/.zshrc.local
fi
