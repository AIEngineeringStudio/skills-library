GIT INSTALLATION AND SETUP GUIDE
----------------------------------------------------------------


----------------------------------------------------------------
STEP 1 — INSTALL CLI
----------------------------------------------------------------

macOS:
```bash
brew install git
```

Verify:

```bash
git --version
```
----------------------------------------------------------------

STEP 2 — GLOBAL CONFIGURATION
----------------------------------------------------------------


🔑 TERM: Global config → settings stored in ~/.gitconfig
Applied to every repo on your machine.

----------------------------------------------------------------

### Run these commands once per machine:

```bash
git config --global user.name  "Your Full Name"
```

```bash
git config --global user.email "you@example.com"
```

```bash
git config --global core.editor "code --wait"
```

```bash
git config --global init.defaultBranch main
```

### core.editor options:

VS Code →  "code --wait"
Vim →  "vim"
Nano →  "nano"

Verify:
git config --global --list

```