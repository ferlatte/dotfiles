[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/ferlatte/dotfiles/main.svg)](https://results.pre-commit.ci/latest/github/ferlatte/dotfiles/main)

# dotfiles

My personal dotfiles.

clone into `~/.dotfiles`.

cd .dotfiles

stow zsh
stow emacs
etc.

`hacks/bin/update-all-configs` sort of automates updating everything I use.

## Third party stuff

I use these heavily, and my dotfiles depend on them.

- Homebrew

## prereqs

- stow
- pre-commit

## Setup

### Install Homebrew

Go to http://brew.sh and follow the installation instructions.

```shell
brew install stow pre-commit
```

### Install dotfiles

```shell
git clone git@github.com:ferlatte/dotfiles.git ~/.dotfiles
cd .dotfiles
make install
```

### Everything else

`update-all-configs`. Run it once here, and periodically after that.

It lives in `~/bin`, which `make install` stows and `.zshrc` puts on `PATH`, so
start a new login shell first.

```shell
exec zsh -l
update-all-configs
```
