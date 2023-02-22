[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/ferlatte/dotfiles/main.svg)](https://results.pre-commit.ci/latest/github/ferlatte/dotfiles/main)

# dotfiles
My personal dotfiles.

clone into `~/.dotfiles`.

cd .dotfiles

stow bash
stow emacs
etc.

`hacks/bin/update-all-configs` sort of automates updating everything I use.

## Third party stuff

I use these heavily, and my dotfiles depend on them.

* EMACS Prelude: https://github.com/bbatsov/prelude
* Homebrew

## prereqs

- stow

## Setup

### Install Homebrew

Go to http://brew.sh and follow the installation instructions.

``` shell
brew install stow
```

### Install EMACS Prelude

`git clone https://github.com/bbatsov/prelude.git ~/.emacs.d`

### Checkout dotfiles

``` shell
git clone git@github.com:ferlatte/dotfiles.git ~/.dotfiles
cd .dotfiles
stow [a-z]*

```
