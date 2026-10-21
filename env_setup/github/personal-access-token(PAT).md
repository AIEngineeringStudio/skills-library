# GITHUB PERSONAL ACCESS TOKEN (PAT)

## Goal

Create a token to use in API scripts.

----------------------------------------------------------------
STEP 1 — CREATE A GITHUB PERSONAL ACCESS TOKEN (PAT)
----------------------------------------------------------------

🔑 TERMS:

PAT (Personal Access Token)
→ A password substitute for Git over HTTPS.
→ Token that replaces your GitHub password.

SCOPE: 
→ permissions attached to token


## Method: Classic PAT (Recommended for repo transfer)

## Step 1: Open Settings

1. Go to:
   https://github.com/settings/profile

2. In left sidebar:
   → Scroll down
   → Click **Developer settings**

---

## Step 2: Open PAT Section

1. Click:
   → Personal access tokens

2. Click:
   → Tokens (classic)

---

## Step 3: Generate Token

1. Click:
   → Generate new token (classic)

2. You may be asked:
   → Enter password or 2FA

---

## Step 4: Configure Token
1. Go to: https://github.com/settings/tokens
2. Click: "Fine-grained tokens" → "Generate new token"
3. Fill in:
   Token name : my-dev-machine
   Expiration : 90 days (or custom)
---

## Step 5: Select Permissions (IMPORTANT)

✔ Select:

- repo ← REQUIRED

This gives:

- full control of repos
- needed for transfer

1. Under "Repository access":
   Select: "All repositories" OR specific repos
2. Under "Permissions → Repository":
   Contents → Read and write
   Metadata → Read-only (auto-selected)
   Workflows → Read and write (if using GitHub Actions)
---

## Step 6: Generate

1. Click: "Generate token"


## Step 7: Store Token (Terminal)

1. ⚠️ COPY THE TOKEN NOW — You will NOT see it again.
   Store it in a password manager (e.g. 1Password, Bitwarden).

```bash
export GITHUB_TOKEN="paste_token_here"
```


## Step8: Verify Token

```bash
curl -H "Authorization: Bearer $GITHUB_TOKEN" https://api.github.com/user
```
> Expected:
> - your GitHub username JSON


----------------------------------------------------------------
STEP 2 — CONFIGURE CREDENTIAL STORAGE
----------------------------------------------------------------

🔑 TERM: Credential helper
→ Saves your token so you don't retype it every push.

----------------------------------------------------------------

**Option A** — macOS (Keychain) [RECOMMENDED on Mac]

```bash
git config --global credential.helper osxkeychain
```

**Option B** — Windows (Credential Manager) [Auto-set by installer]

```bash
git config --global credential.helper manager
```

**Option C** — Linux (libsecret / GNOME Keyring)

```bash
sudo apt install libsecret-1-0 libsecret-1-dev
```

```bash
sudo make --directory \
/usr/share/doc/git/contrib/credential/libsecret
```

```bash
git config --global credential.helper \
/usr/share/doc/git/contrib/credential/libsecret/\
git-credential-libsecret
```

**Option D** — Plain file storage (any OS, less secure)

```bash
git config --global credential.helper store
```

⚠️ Stores token in plain text at ~/.git-credentials

**First push:** Git will prompt for username + password.
Username: your GitHub username
Password: paste your PAT (not your GitHub password)


----------------------------------------------------------------
PAT ACCESS TO ORGS — HOW IT WORKS
----------------------------------------------------------------

YOUR PERSONAL PAT
-----------------

- A PAT always belongs to YOUR personal account.
- It can access your personal repos automatically.
- For org repos → the org must GRANT access to your PAT.

----------------------------------------------------------------
CONDITION — ORG MUST ALLOW PAT ACCESS
----------------------------------------------------------------

Each org has a policy setting:

```
  Policy                  What it means
  --------------------    ----------------------------------
  Allow all PATs          Your PAT works immediately
  Allow selected PATs     You must request access per org
  Restrict all PATs       PATs blocked — must use OAuth App
                          or GitHub App instead
```

----------------------------------------------------------------
HOW TO CHECK / REQUEST ORG ACCESS
----------------------------------------------------------------

**Step 1** — When creating the PAT:

```
  GitHub → Settings → Developer Settings
  → Personal access tokens → Fine-grained tokens
  → "Resource owner" dropdown
     → Select YOUR USERNAME  (personal repos only)
     → OR select an ORG NAME (if org allows it)

  ⚠️  You create ONE PAT per resource owner.
      You cannot select multiple orgs in one PAT.
```

**Step 2** — If org requires approval:

```
  After creating the PAT, you'll see:
  "Request access" button next to the org name.
  An org admin must approve it.
```

----------------------------------------------------------------
PRACTICAL APPROACH FOR MULTIPLE ORGS
----------------------------------------------------------------

```
  Scenario               Recommendation
  -------------------    --------------------------------
  1 personal + 1 org     Create 2 PATs, one each
  1 personal + 3 orgs    Create 1 PAT per org + 1 personal
  Orgs block PATs         Use SSH keys instead (simpler)
```

----------------------------------------------------------------
RECOMMENDATION — USE SSH KEYS FOR MULTI-ORG SETUPS
----------------------------------------------------------------

```
  SSH keys work across all orgs without per-org approval.
  One key pair → add public key to GitHub once → done.

  Want instructions for SSH key setup instead?
```

----------------------------------------------------------------