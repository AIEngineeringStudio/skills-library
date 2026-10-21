Fix IntelliJ (JetBrains) GitHub auth
----------------------------------------------------------------

### 1) Make sure SSH works in Terminal

```bash
ssh -T git@github.com
```

**Expected:** a success message (first time may ask to trust host).

If this fails, fix SSH first (key + add to GitHub), then come back.

---

### 2) Tell IntelliJ to use your system Git + SSH

1. **IntelliJ → Settings** (Preferences on macOS)
2. **Version Control → Git**
    - **Path to Git executable:** usually `/usr/bin/git`
    - Click **Test** (must succeed)
3. **Tools → SSH Configurations**
    - Click **+**
    - Host: `github.com`
    - Username: `git` (GitHub SSH always uses **user** `git`)
    - **Authentication type:** Key pair
    - **Private key file:** `~/.ssh/id_ed25519`
    - Apply / OK

**Note**

GitHub provides SSH on `ssh.github.com:443` specifically for networks that
block `port 22`.

----------------------------------------------------------------

### 4) Push from IntelliJ
----------------------------------------------------------------

- Git tool window → **Push**
- It should not ask for username/password.

----------------------------------------------------------------

----------------------------------------------------------------
## HTTPS + PAT (if you must)
----------------------------------------------------------------

### 1) Sign in to GitHub in IntelliJ

1. **Settings → Version Control → GitHub**
2. **Add account**
3. Choose **Log In via Token**
4. Paste a GitHub **Personal Access Token (PAT)**


### 2) Ensure remote is HTTPS

```bash
git remote set-url origin https://github.com/[GitHub username]/[git-repo name].git
```


### 3) Push

- IntelliJ should use the stored token.

**If IntelliJ keeps asking for a password:** it’s using the macOS Keychain
entry or old credentials. Clear them (see “Clean up old creds” below).


