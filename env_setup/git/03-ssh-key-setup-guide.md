# SSH KEY SETUP — COMPLETE GUIDE
----------------------------------------------------------------

KEY CONCEPTS
----------------------------------------------------------------

```
🔑 TERM: SSH key pair
         Two files generated together:
         - Private key  → stays on YOUR machine only
         - Public key   → uploaded to GitHub (safe to share)

🔑 TERM: ssh-agent
         A background process that holds your key in memory
         so you don't re-enter your passphrase every time.

🔑 TERM: ed25519
         The recommended key algorithm. Shorter and more
         secure than the older RSA type.
```

----------------------------------------------------------------
STEP 1 — GENERATE KEY PAIR
----------------------------------------------------------------

```
  ssh-keygen -t ed25519 -C "you@example.com"

  Prompts you will see:
  ┌─────────────────────────────────────────────────────┐
  │ Enter file: press Enter  (use default path)         │
  │ Enter passphrase: type a strong passphrase          │
  │ Confirm passphrase: repeat it                       │
  └─────────────────────────────────────────────────────┘

  Files created:
    ~/.ssh/id_ed25519       ← private key  (NEVER share)
    ~/.ssh/id_ed25519.pub   ← public key   (upload this)

  ⚠️  If ~/.ssh/id_ed25519 already exists, ssh-keygen
      will ask to overwrite. Say NO and use the existing
      key unless you want to replace it.
```

----------------------------------------------------------------
STEP 2 — ADD KEY TO SSH-AGENT
----------------------------------------------------------------

```
  Start the agent:
    eval "$(ssh-agent -s)"

  Add your key:

    Linux / Windows (Git Bash):
      ssh-add ~/.ssh/id_ed25519

    macOS (also saves to Keychain):
      ssh-add --apple-use-keychain ~/.ssh/id_ed25519

  macOS: also create/edit ~/.ssh/config:
  ┌─────────────────────────────────────────────────────┐
  │  Host github.com                                    │
  │    AddKeysToAgent yes                               │
  │    UseKeychain yes                                  │
  │    IdentityFile ~/.ssh/id_ed25519                   │
  └─────────────────────────────────────────────────────┘
  This auto-loads the key on reboot.
```

----------------------------------------------------------------
STEP 3 — ADD PUBLIC KEY TO GITHUB
----------------------------------------------------------------

```
  Copy your public key:

    macOS:
      pbcopy < ~/.ssh/id_ed25519.pub

    Linux:
      cat ~/.ssh/id_ed25519.pub
      (then select and copy the output)

    Windows (Git Bash):
      clip < ~/.ssh/id_ed25519.pub

  Then on GitHub:
    1. Settings → SSH and GPG keys
    2. Click: "New SSH key"
    3. Title: e.g. "My MacBook 2025"
    4. Key type: Authentication Key
    5. Paste the public key
    6. Click: "Add SSH key"

  ✅ Do this ONCE per machine.
  ✅ Works for personal account AND all linked orgs.
     No per-org approval needed.
```

----------------------------------------------------------------
STEP 4 — TEST THE CONNECTION
----------------------------------------------------------------

```
  ssh -T git@github.com

  Expected output:
    Hi YOUR_USERNAME! You've successfully authenticated,
    but GitHub does not provide shell access.

  If you see this → SSH is working correctly.
```

----------------------------------------------------------------
STEP 5 — UPDATE REMOTE URLs FOR EXISTING LOCAL REPOS
----------------------------------------------------------------

1. Verify existing repo uses HTTPS.
    ```bash
        git remote -v
    ```
   If you see `https://github.com/USER/REPO.git`, it needs to be updated

2. Switch to SSH:
    - Commands:
    ```bash
        git remote set-url origin git@github.com:USER/REPO.git
    ```
    - Verify
    ```bash
        git remote -v
    ```
      If you see `git@github.com:USER/REPO.git`, you are good to go.

----------------------------------------------------------------
MULTI-ORG — HOW SSH HANDLES IT
----------------------------------------------------------------

```
  Your SSH key is linked to YOUR GitHub account.
  GitHub identifies you by the key, not the URL.

  Access per context:
  ┌──────────────────┬──────────────────────────────────┐
  │ Context          │ Access                           │
  ├──────────────────┼──────────────────────────────────┤
  │ Personal repos   │ Always works                     │
  │ Org repos        │ Works if you are a member        │
  │ Private org repo │ Works if you have repo access    │
  └──────────────────┴──────────────────────────────────┘

  No per-org token approval. No separate keys per org.
  One key pair → one GitHub account → all your orgs.
```

----------------------------------------------------------------
SUMMARY — CHECKLIST
----------------------------------------------------------------

```
  [ ] ssh-keygen run → two files created in ~/.ssh/
  [ ] Private key NEVER shared or uploaded
  [ ] ssh-agent started and key added
  [ ] ~/.ssh/config created (macOS)
  [ ] Public key pasted into GitHub settings
  [ ] SSH connection tested: ssh -T git@github.com
```

----------------------------------------------------------------