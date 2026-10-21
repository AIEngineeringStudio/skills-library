LINK LOCAL REPO TO GITHUB — USING GITHUB CLI
----------------------------------------------------------------

----------------------------------------------------------------

FOR REPOS USING SSH (RECOMMENDED)
----------------------------------------------------------------

When adding a remote, use SSH format (not HTTPS):

1. For existing repos using HTTPS, switch to SSH:
   - HTTPS: https://github.com/USER/REPO.git
   - Commands:
    ```bash
        git remote set-url origin git@github.com:<USER/ORG>/<REPO_NAME>.git
    ```

2. For existing repos using SSH:
    - git@github.com:USER/REPO.git
    - Commands:
   ```bash
       git remote add origin git@github.com:<USER/ORG>/<REPO_NAME>.git
   ````

   ```bash
       git push -u origin main
   ````
    > -u flag = sets upstream (only needed on first push)
      For future pushes, just use `git push`


----------------------------------------------------------------

FOR REPOS USING HTTPS URL
----------------------------------------------------------------

When adding a remote, use SSH format (not HTTPS):

1. HTTPS

   ```bash
       git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   ````

   ```bash
      git branch -M main
   ```
   >  `git branch` — manages branches  
      `-M` — rename forcibly  
      `main` — the new branch name

   ```bash
       git push -u origin main
   ````
