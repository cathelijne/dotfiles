#!/bin/bash

# Git pull a full tree of repositories.

# This will run from $PWD.
# If you want to always run from the diroctory where the script
# is, swap the $ORIGIN lines below. You can also set $THIS_DIR
# if you want to run from a specific directory.
THIS_DIR=${PWD}
ORIGIN=$(readlink -f $THIS_DIR)
# ORIGIN=$(dirname $(readlink -f $0))

for i in $(find ${ORIGIN} -type d -name .git); do
  echo "Fetching and pulling ${i}"
  cd $(dirname $i)
  git fetch
  git pull
  gitleaks detect
  echo "\n\n\n"
  read -n 1 -s -r -p "Press any key to continue"
done

cd ${THIS_DIR}
