## GH Personal vs Org Account

[Personal vs Org Account](github_personal_vs_org.svg)

```
┌─────────────────────────────────────────────────────────────┐
│ KEY DIFFERENCES                                             │
├──────────────────┬──────────────────┬───────────────────────┤
│ Feature          │ /mygeekboxpro    │ /orgs/SkillForgeLab   │
├──────────────────┼──────────────────┼───────────────────────┤
│ Account type     │ Personal         │ Organization          │
│ Repo ownership   │ You (one person) │ The org entity        │
│ Teams/roles      │ No               │ Yes                   │
│ Billing          │ Personal         │ Centralized           │
│ Member mgmt      │ No               │ Yes (admin controls)  │
│ URL pattern      │ /mygeekboxpro/X  │ /SkillForgeLab/X      │
└──────────────────┴──────────────────┴───────────────────────┘
```

## Requirements (Important)

You must:

- Own the repository
- Have permission to create repos in the org
- Organization must allow:
    - Repository transfers
- If repo is private:
    - Check organization plan supports private repos

## Method 1: Transfer via GitHub UI (Recommended)

### Steps

1. Open your repository (on your profile).
2. Click **Settings**.
3. Scroll to bottom → **Danger Zone**.
4. Click **Transfer ownership**.
5. Enter:
    - Repository name (confirmation)
    - Organization name
6. Click **I understand, transfer this repository**.

## Method 2: GitHub API (Advanced)

### HOW TO RUN

1. Verify you are authenticated:
      ```bash
         gh auth status
      ```

2. Confirm your auth has correct scope:
      ```bash
         gh auth refresh -s delete_repo,write:org
      ```
   > Note: Transfer requires admin scope
   on both source repo and target org.

3. Dry-run first — list repos only:
      ```bash
         gh repo list mygeekboxpro \
         --limit 100 \
         --json name \
         -q '.[].name'
      ```

4. Run the batch script below.

```
1. Make executable
chmod +x gh_transfer_repos.sh

2. MODES:
    personal-to-org  |  personal account → organization
    org-to-personal  |  organization     → personal account
    org-to-org       |  organization     → organization

3. SOURCE:
   Create your repo list file (repos.txt)
   One repo name per line.
   Blank lines and # comments are skipped.
   
4. ARGUMENTS:
    --mode     Choose mode from Step 2
    --source   GitHub username or org name (source)
    --target   GitHub username or org name (target)
    --file     Path to .txt file, one repo name per line (from Step 3)

5. Execute one of the script versions

   ./gh_transfer_repos.sh \
     --mode <MODE> \
     --source <SOURCE> \
     --target <TARGET> \
     --file <REPOS_FILE> 

   # Optional: custom log file name 
   ./gh_transfer_repos.sh \
     --mode <MODE> \
     --source <SOURCE> \
     --target <TARGET> \
     --file <REPOS_FILE> \
     --log my_transfer.log   

```

---

## After Transfer (Critical Steps)

1. Update Local Repo's Remote URL

```bash
git remote set-url origin https://github.com/<org>/<repo>.git
```

