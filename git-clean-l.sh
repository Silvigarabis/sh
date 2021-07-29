git count-objects -vH

git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now
git gc --aggressive --prune=now

git count-objects -vH
