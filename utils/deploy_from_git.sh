#!/usr/bin/env bash
##############################################################################
#
# Author: Jordi Andreu
# Last revision: 20 Dec 2018
#
# Create a tar archive that contains the contents of the latest commit
# on the current branch.
#
##############################################################################

# Check that the first argument is not an empty string and it is a valid
# existing directory.
if ([[ -z "$1" ]] || [[ ! -d $1 ]])
  then
    echo "You MUST supply a valid directory to deploy the solution. Exiting!."
    exit -1
fi

# Set the deployment folder
DEPLOYDIR=$1

# Check we are in a git repository.
ROOT=$(git rev-parse --show-toplevel)

if [[ $ROOT == *"fatal"* ]]; then
  echo "We are not into a valid git repository. Existing!"
  exit -1
fi

# Get the repository folder root name.
REPONAME=$(basename $ROOT)

# Get the hash of the latest commit.
HASH=$(git log --pretty=format:'%h' -n 1)

# Get current date.
DATE=`date '+%Y%m%d_%H%M%S'`
#DATE=`date '+%Y%m%d'`

NAME=$REPONAME-$DATE-$HASH
TARGZFILE=$NAME.tar.gz

# Archive the repository to a tar-gz file
echo "Archiving repository $REPONAME as $TARGZFILE"
git archive --format=tar --prefix=$NAME/ HEAD | gzip >$TARGZFILE

# Extract the archived code to production folder
echo "Deploying repository $REPONAME to $DEPLOYDIR"
mv $TARGZFILE $DEPLOYDIR
pushd $DEPLOYDIR > /dev/null
    tar -xf $TARGZFILE
    if [[ -L $REPONAME ]]; then
        rm -r $REPONAME
    fi
    ln -s $NAME $REPONAME
popd > /dev/null
echo "Done."
