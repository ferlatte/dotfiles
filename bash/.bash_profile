# .bash_profile -*- Mode: Shell-script; -*-
# shellcheck shell=bash

# Load .bashrc at login also.
# shellcheck disable=SC1091
# shellcheck source=.bashrc
[[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
