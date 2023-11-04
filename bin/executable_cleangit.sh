#!/bin/sh


[[ -n $(git status -s) ]] && echo "Your branch is dirty! Please commit all changes before you run this script or they'll be gone forever." && exit 1

branch=$(git rev-parse --abbrev-ref HEAD)
git checkout --orphan clean-${branch}
git add -A
git commit -m "Cleaning up ${branch}"
git branch -D ${branch}
git branch -m ${branch}
git push -f origin ${branch}

