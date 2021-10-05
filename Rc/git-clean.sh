git count-objects -vH

git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now
git gc --aggressive --prune=now

git push origin --force
git remote prune origin

git count-objects -vH
