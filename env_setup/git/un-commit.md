Yes.

You can undo a commit **before pushing to origin**.  
The method depends on what you want to keep.

--------------------------------------------------
CASE 1 — Undo commit but KEEP the changes
--------------------------------------------------

Command:

git reset --soft HEAD~1

Result:

Commit removed
Changes stay staged

Diagram:

Before
A — B — C (HEAD)

After
A — B (HEAD)
      ↑
   changes staged


--------------------------------------------------
CASE 2 — Undo commit and keep changes UNSTAGED
--------------------------------------------------

Command:

git reset HEAD~1

or

git reset --mixed HEAD~1

Result:

Commit removed
Changes remain in working directory

Diagram:

Before
A — B — C (HEAD)

After
A — B (HEAD)
      ↑
   changes in working directory


--------------------------------------------------
CASE 3 — Undo commit and DELETE the changes
--------------------------------------------------

Command:

git reset --hard HEAD~1

Result:

Commit removed
Changes deleted permanently

Diagram:

Before
A — B — C (HEAD)

After
A — B (HEAD)


--------------------------------------------------
Important Terms
--------------------------------------------------

HEAD  
Pointer to the latest commit in the current branch.

origin  
Remote repository (GitHub, GitLab, etc).

HEAD~1  
The commit **one step before HEAD**.


--------------------------------------------------
Quick Summary
--------------------------------------------------

Keep changes staged:
git reset --soft HEAD~1

Keep changes unstaged:
git reset HEAD~1

Delete commit and changes:
git reset --hard HEAD~1


--------------------------------------------------
Key Point to Remember
--------------------------------------------------

You can safely rewrite commits **before pushing**.

Once pushed to origin, history rewriting becomes risky.


--------------------------------------------------
Quick check question

Did you want to:

A) change the commit message  
B) add more files to the commit  
C) completely remove the commit

Tell me the case. I will show the safest command.
