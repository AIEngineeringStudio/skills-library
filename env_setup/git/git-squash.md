### Squash commit
git fetch origin
git checkout <<branch>>

git log

Commit  7cc81ec1175
Author: Sreedhar
Date:
        add a paragraph to README.md

Commit  462006cbe87
Author: Sreedhar
Date:
        add a header to README.md

Commit  60096d75312
Author: Sreedhar
Date:
        Create README.md

Commit  e235f83c51a
Author: Sreedhar
Date:
        previous history
Commit  d64c262d39f
Author: Sreedhar
Date:
        ancient history
----------------------------------------------------------------------------------------------

### Copy the commit hash one previous of the earliest to be combined
### If you want to combine 7cc81ec1175, 462006cbe87, 60096d75312, then copy e235f83c51a

\# git rebase -i <<commit hash from git log>>

get rebase -i origin/master

----------------------------------------------------------------------------------------------

### edit files, if there are conflicts
### If you leave all the "pick" as is, the history won't change.

pick 60096d75312  Create README.md
pick 462006cbe87 add a header to README.md
pick 7cc81ec1175 add a paragraph to README.md

For this example, we'll change to
pick 60096d75312  Create README.md
squash 462006cbe87 add a header to README.md
squash 7cc81ec1175 add a paragraph to README.md

# Write and quit (:wq)

----------------------------------------------------------------------------------------------
### Edit the commit message

### Write and quit again (:wq)

git add <edited file>
git rebase --continue

### Repeat above steps for each conflict
----------------------------------------------------------------------------------------------

git push origin -f <<branch-name>>

