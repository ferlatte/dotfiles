SHELL = /bin/bash
PRE-COMMIT := $(shell which pre-commit)

all: pre-commit .prereqs.stamp install

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

# We need to handle LaunchAgents as a special case; macOS doesn't create automatically,
# and we can't assume other software won't put it there. Therefor, ensure it exists *before*
# stow runs
install: .prereqs.stamp
	mkdir -m 0755 -p $(HOME)/Library/LaunchAgents
	stow */

clean:
	rm -f .*.stamp

.PHONY: all clean pre-commit install
