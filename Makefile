SHELL = /bin/bash
PRE-COMMIT := $(shell which pre-commit)

.PHONY: all
all: pre-commit .prereqs.stamp install

.PHONY: pre-commit
# Shortcut to run pre-commit hooks over the entire repo.
pre-commit: .git/hooks/pre-commit
	pre-commit run --all-files

# Update the pre-commit hooks if the pre-commit binary is updated.
.git/hooks/pre-commit: $(PRE-COMMIT)
	pre-commit install

# Re-check prereqs if the prereqs configuration is newer than the last time
# we checked.
.prereqs.stamp: README.md
	.bin/prereqs -r README.md
	touch .prereqs.stamp

.PHONY: install
install: .prereqs.stamp
	git config gpg.ssh.allowedSignersFile .etc/committer.keys
# Refuse to pull a tip commit that isn't signed by a key in committer.keys.
	git config merge.verifySignatures true
# This verifies all commits since I started signing them reliably, and lists any that fail.
	! git log --format='%G? %h %s' e68189b..HEAD | grep -v '^G'
# We need to handle LaunchAgents & Applications as special cases; macOS doesn't create automatically,
# and we can't assume other software won't put things there. Therefor, ensure they exist before
# stow runs
	mkdir -m 0755 -p $(HOME)/Applications
	mkdir -m 0755 -p $(HOME)/Library/LaunchAgents
	stow -R */

.PHONY: clean
clean:
	rm -f .*.stamp
