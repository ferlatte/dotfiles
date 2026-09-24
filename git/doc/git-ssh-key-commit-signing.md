# Git ssh key commit signing

Used https://calebhearth.com/sign-git-with-ssh as a reference.

Also, this was useful: https://dev.to/li/correctly-telling-git-about-your-ssh-key-for-signing-commits-4c2c

In particular: if you want to specific the public key in your config you want to prefix it with key::, like that article says.

1Password holds the signing ssh keys, and has its own helper which is configured in `.gitconfig`.

For my dotfiles repository, I then:

Made .etc/committer.keys, with my public key in it.

I added my ssh key to github as a signing key, which gives a nice "Verified" flair on commits.

To deal with multiple ssh keys (which you need to do, since sometimes keys are tied to hardware), I chose to set user.signingkey for each repository locally, with a default for the computer that I use the most. There is likely a smarter way to deal with this.

I just have `make install` configure git for my dotfiles to check signers.
