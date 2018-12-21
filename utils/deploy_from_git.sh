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
DEPLOY_PATH=$1

# Check we are in a git repository.
ROOT=$(git rev-parse --show-toplevel)

if [[ ${ROOT} == *"fatal"* ]]; then
  echo "We are not into a valid git repository. Existing!"
  exit -1
fi

# Get the repository folder root name.
REPO_NAME=$(basename ${ROOT})

# Get the hash of the latest commit.
HASH=$(git log --pretty=format:'%h' -n 1)

# Get current date.
DATE=`date '+%Y%m%d_%H%M%S'`
#DATE=`date '+%Y%m%d'`

NAME=${DATE}-${REPO_NAME}-${HASH}
TAR_GZ_FILE=${NAME}.tar.gz

# Archive the repository to a tar-gz file
echo "Archiving $REPO_NAME repository: $TAR_GZ_FILE"
git archive --format=tar --prefix=${NAME}/ HEAD | gzip >${TAR_GZ_FILE}

# Extract the archived code to production folder
echo "Deploying $REPO_NAME: $DEPLOY_PATH"
mv ${TAR_GZ_FILE} ${DEPLOY_PATH}
pushd ${DEPLOY_PATH} > /dev/null
    tar -xf ${TAR_GZ_FILE}
    if [[ -L ${REPO_NAME} ]]; then
        rm -r ${REPO_NAME}
    fi
    ln -s ${NAME} ${REPO_NAME}
popd > /dev/null
