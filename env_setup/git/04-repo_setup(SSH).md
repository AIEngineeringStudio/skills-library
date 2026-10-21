CREATE REPO FROM LOCAL — USING GITHUB CLI
----------------------------------------------------------------

## Requirements

1. [GITHUB CLI is installed and configured](00-ghi-cli-install-config.md)
2. [GIT CLI is installed and configured](01-git-installation-config.md)
3. [Verify git configuration](02-view-existing-git-config.md)

----------------------------------------------------------------
STEP 1 — SET UP LOCAL PROJECT
----------------------------------------------------------------

- Navigate to your project folder (or create one):
    ```bash
        mkdir my-project && cd my-project
    ```

- Initialize git:
    ```bash
        git init
    ```

----------------------------------------------------------------
STEP 2 — FIRST COMMIT AND PUSH
----------------------------------------------------------------

- Create README.md 
  ```bash
    echo "# README" >> README.md
  ```
  
- Stage all files:

  ```bash
      git add .
  ```
- Create initial commit:

  ```bash
      git commit -m "First commit"
  ```

- Rename branch as main
  ```bash
      git branch -M main
  ```

----------------------------------------------------------------
STEP 3 — CREATE GITHUB REPO AND PUSH TO ORG (GH-CLI)
----------------------------------------------------------------

- Create remote org repo AND push in one command:
    ```bash
        gh repo create ORG_NAME/REPO_NAME \
          --private \
          --source=. \
          --remote=origin \
          --push
    ```
  ```
  Flags explained:
  ┌─────────────────┬─────────────────────────────────────┐
  │ Flag            │ What it does                        │
  ├─────────────────┼─────────────────────────────────────┤
  │ --private       │ Private repo (or use --public)      │
  │ --source=.      │ Use current folder as source        │
  │ --remote=origin │ Name the remote "origin"            │
  │ --push          │ Push immediately after creating     │
  └─────────────────┴─────────────────────────────────────┘
   ```

----------------------------------------------------------------
STEP 4 — VERIFY
----------------------------------------------------------------

git remote -v
gh repo view --web ← opens repo in browser


----------------------------------------------------------------
FULL COMMAND SEQUENCE (copy-paste ready)
----------------------------------------------------------------

mkdir my-project && cd my-project
git init
git add .
git commit -m "Initial commit"
gh repo create ORG_NAME/REPO_NAME \
--private \
--source=. \
--remote=origin \
--push
git remote -v


----------------------------------------------------------------
KEY TERMS TO MEMORIZE
----------------------------------------------------------------

```
Repository     →   Folder tracked by Git
Commit         →   Saved snapshot of changes
Branch         →   Parallel line of work
Remote         →   Repo hosted on GitHub
Origin         →   Default name for your GitHub remote
PAT            →   Token used instead of password
Upstream (-u)  →   Link between local/remote branch
Staging        →   area Files queued before a commit
```
