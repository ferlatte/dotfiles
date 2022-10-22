# Git ssh key commit signing

Used https://calebhearth.com/sign-git-with-ssh as a reference.

Also, this was useful: https://dev.to/li/correctly-telling-git-about-your-ssh-key-for-signing-commits-4c2c

In particular: if you want to specific the public key in your config (which, with secretive, you do), you want to prefix it with key::, like that article says.

However, once I did that, it worked.

For my dotfiles repository, I then:

Made .etc/committers.keys, with my public key in it.

Ran `git config gpg.ssh.allowedSignersFile ./.etc/committers.keys`

Then added my ssh key to github as a signing key, which gives a nice "Verified" flair on commits.


