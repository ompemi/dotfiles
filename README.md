# My dotfiles

## Contents

* bash: Bash setup, .bashrc, aliases and cmd reminders ($ myexample*).
* vim: basic vim setup and shortcuts.
* git: git-completion, branch in prompt, sample usages ($ myexamplegit)
* screen: ready to go screen config

## Installation

You can clone the repository wherever you want. The install script will backup your current dotfiles and copy the new ones to your home folder.

```bash
git clone https://github.com/ompemi/dotfiles.git && cd dotfiles && ./install.sh
```

## Uninstall

To restore the previous dotfiles:

```bash
cd <repository_path> && mv -f original/.* ~/
```
