Goal

- Stop tracking files in Git.
- Keep the files on disk.

Common cases

1) Untrack ONE file (keep it locally)

- Run:
  git rm --cached path/to/file

  **Example: untrack .env**
  git rm --cached .env
  echo ".env" >> .gitignore
  git add .gitignore
  git commit -m "Stop tracking .env"

2) Untrack a folder (keep it locally)

- Run:
  git rm -r --cached path/to/folder

3) Untrack EVERYTHING, then re-add (useful after changing .gitignore)

- Run:
  git rm -r --cached .
  git add .
  git commit -m "Stop tracking ignored files"

You should also add rules to .gitignore
Example (common Python)

- Add to .gitignore:
  .env
  __pycache__/
  .venv/
  .python-version
  *.pyc

Then commit .gitignore

- Run:
  git add .gitignore
  git commit -m "Update .gitignore"

Check what is tracked

- Run:
  git ls-files | head

Key terms to memorize

- tracked: Git is watching this file and includes it in commits.
- untracked: Git sees it but will not commit it unless you add it.
- cached: Git index (staging area). --cached removes from Git index only.

Summary

- Use: git rm --cached <file_or_folder>
- Add it to .gitignore so it stays untracked.
- Commit the change.

> ### Meaning of “--cached” with git rm
> What “cached” means
> - “Cached” means “in Git’s index”.
> - The index is the staging area.
> - It is the list of files Git tracks for the next commit.
>
> So this command:
> - git rm --cached path/to/file
>
> Does this
> - Removes the file from Git tracking (from the index).
> - Keeps the file on your computer (your working directory).
>
> Without --cached
> - git rm path/to/file
> - Removes the file from Git tracking.
> - Also deletes the file from your computer.
>
> Small diagram
>
> Working directory (your disk)  ->  Index (staging)  ->  Commit (history)
> file exists tracked recorded
>
> git rm --cached removes it here:
> Index (staging)
>
> Example
> - If you accidentally committed .env, you do:
    > git rm --cached .env
    > echo ".env" >> .gitignore
    > git add .gitignore
    > git commit -m "Stop tracking .env"
>
> Key terms to memorize
> - index: staging area.
> - working directory: your files on disk.
> - commit: saved snapshot in Git history.
>
> Summary
> - --cached = untrack it, but keep it on disk.
>