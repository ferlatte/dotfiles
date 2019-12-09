# How to use a YubiKey

Installed GPGSuite instead of from brew, and installed the YubiKey tools:

    brew cask install gpgsuite
    brew install ykman ykpers

Did no shell configuration at all.

`gpg —card-edit` popped up a nice UI window for pin entries.

If you want to use the Yubikey for ssh keys, you need to use the GPGSuite `gpg-agent` instead of `ssh-agent`; edit `~/.ssh/config` and make sure IdentityAgent looks like this:

     IdentityAgent ~/.gnupg/S.gpg-agent.ssh

Followed Eric's doc for everything else around generating the actual keys.
