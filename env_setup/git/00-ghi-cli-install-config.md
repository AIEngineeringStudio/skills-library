GITHUB INSTALLATION AND SETUP GUIDE
----------------------------------------------------------------

----------------------------------------------------------------

STEP 1 — INSTALL GitHub CLI (gh) 
----------------------------------------------------------------


## Where to Get It — Official Source (Best)

- Website: https://cli.github.com/
- This is the official tool from GitHub

macOS:

```bash
    brew install gh
```

Verify:

```bash
    gh --version
```

----------------------------------------------------------------
STEP 2 — AUTHENTICATE GITHUB CLI (GH-CLI)
----------------------------------------------------------------

### Device Activation - First Setup (Important)

> **What it does**
> - Connects CLI to your GitHub account
> - Opens browser for login

```bash
    gh auth login
```

```
Prompts:
┌──────────────────────────────────────────────────────┐
│ Where do you use GitHub?  → GitHub.com               │
│ Preferred protocol?       → SSH                      │
│ Upload your SSH key?      → Yes (select your key)    │
│ Authenticate?             → Login with a web browser │
└──────────────────────────────────────────────────────┘

This opens a browser → log in → paste the code shown.
```

Verify:

```bash
    gh auth status
```

## Key Commands (Memorize)

| Command          | Purpose         |
|------------------|-----------------|
| gh auth login    | Login to GitHub |
| gh repo clone    | Clone repo      |
| gh repo create   | Create repo     |
