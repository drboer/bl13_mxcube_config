#!/usr/bin/env bash

# Create a tar archive that contains the contents of the latest commit
# on the current branch.

ROOT=$(git rev-parse --show-toplevel)
echo $ROOT

if [[ $ROOT == *"fatal"* ]]; then
  echo "No repository!"
  exit -1
fi

NAME=$(basename $ROOT)
echo $NAME

HASH=$(git log --pretty=format:'%h' -n 1)

ZIPFILE=$NAME-$HASH.tar.gz

git archive --format=tar --prefix=$NAME/ HEAD | gzip >$ZIPFILE

# Extract the snapshot to production folder
PRODDIR=$1

mv $ZIPFILE $PRODDIR
pushd $PRODDIR
    tar -xf $ZIPFILE
popd

