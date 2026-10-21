

QUICK REFERENCE — DAILY COMMANDS
----------------------------------------------------------------

```
git status Check what changed
git add . Stage all changes
git add <file>          Stage one file
git commit -m "msg"     Save a snapshot
git push Upload to GitHub
git pull Download latest from GitHub
git log --oneline See commit history
```

------------------------------------------------------------------------------
Configuring git for the first time
------------------------------------------------------------------------------

* git config --get remote.origin.url

* git config --global user.name "suswaram"
* git config --global user.email "git.suswaram@gmail.com"


------------------------------------------------------------------------------
Reset Password
------------------------------------------------------------------------------
* git config --global --unset user.password


------------------------------------------------------------------------------
Set Buffer size
------------------------------------------------------------------------------
* git config --global http.postBuffer 524288000

(OR 957286400 OR 999999990)

------------------------------------------------------------------------------
Initial Config and Commit
------------------------------------------------------------------------------

- Navigate to project root folder

    * git init
    * git add * // git add -all
    * git commit -m "Initial Commit"
    *
    * git remote add
    * origin https://github.com/git-suswaram/react-jest-enzyme-simple-tut.git
    *
    * git push -u origin master

------------------------------------------------------------------------------
Update workspace with latest code from repository
------------------------------------------------------------------------------

* git fetch
* git branch --set-upstream-to=origin/master master
* git remote -v
* git pull origin master --allow-unrelated-histories
* git push -u origin master

------------------------------------------------------------------------------
Reset git config for a project
------------------------------------------------------------------------------

* rm -Rf .git

------------------------------------------------------------------------------
Create Repo using API
------------------------------------------------------------------------------

* curl -u 'git-suswaram' https://api.github.com/user/repos -d '{"name":"
  certificate-management"}'

------------------------------------------------------------------------------
Cloning specific branch
------------------------------------------------------------------------------

* git clone <<git-repo-URL>> -b <<branch-name: ex-feature/mybranch>>

------------------------------------------------------------------------------
Pushing code to repository
------------------------------------------------------------------------------

* git remote set-url origin <<git-repo-url>>
* git push -u origin --all
* git push origin --tags

------------------------------------------------------------------------------
Find the git URL associated with the repository
------------------------------------------------------------------------------

* git config --get remote.origin.url

------------------------------------------------------------------------------
Print all your remotes
------------------------------------------------------------------------------

* git remote -v

------------------------------------------------------------------------------
Branch Operations
------------------------------------------------------------------------------

------------------------------------------------------------------------------
Print current branch
------------------------------------------------------------------------------

* git branch

------------------------------------------------------------------------------
List all your branches
------------------------------------------------------------------------------

* git branch -a

------------------------------------------------------------------------------
Checkout to Branch (Create, switch and checkout)
------------------------------------------------------------------------------

- Navigate to project root folder

    * git checkout -b testingComponents
    * git checkout --force testingComponents
    * git reset HEAD yarn.lock

    * git add -A -n
    * git fetch origin
    * git pull

------------------------------------------------------------------------------
Tag Operations
------------------------------------------------------------------------------

* git tag | sort -n | tail -1
* git checkout 5.0.5

------------------------------------------------------------------------------
Update local clone
------------------------------------------------------------------------------

* git branch -m master main
* git fetch origin
* git branch -u origin/main main
* git remote set-head origin -a

------------------------------------------------------------------------------
To remove last commit from git
------------------------------------------------------------------------------

* git reset --hard HEAD^
* git push -f

### To Reset last two commits from the top

* git reset --hard Head~2
* git push -f













