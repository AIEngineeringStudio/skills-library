## Git orphan branch

### What happens:

- New branch has zero commit history
- Completely disconnected from all other branches
- Shares the same repo/remote, but independent lineage

```shell
git checkout --orphan <new-branch-name>
git rm -rf .          # clears the index (working tree stays)
git commit --allow-empty -m "initial commit"
git push --set-upstream origin <new-branch-name>
```

