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

* Bash-It: https://github.com/Bash-it/bash-it
* EMACS Prelude: https://github.com/bbatsov/prelude
* Brew

## prereqs

- stow

## Setup

### Install Homebrew

Go to http://brew.sh and follow the installation instructions.

``` shell
brew tap "kryptco/tap"
brew install "kryptco/tap/kr"
brew install stow
```

### Install bash-it

``` shell
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
```

### Install EMACS Prelude

`git clone git://github.com/bbatsov/prelude.git ~/.emacs.d`

### Checkout dotfiles

``` shell
git clone git@github.com:ferlatte/dotfiles.git ~/.dotfiles
cd .dotfiles
stow [a-z]*

```
