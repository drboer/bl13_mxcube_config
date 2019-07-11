#!/usr/bin/env bash
##############################################################################
#
# Author: Jordi Andreu
# Last revision: 20 Dec 2018
#
# Deploy MXCuBE project from git repositories
#
##############################################################################

# Log into the mxcube root repository
GIT_PATH=${HOME}/git
DEPLOY_SCRIPT=${GIT_PATH}/bl13_mxcube_config/utils/deploy_from_git.sh
MX3_REPO=${GIT_PATH}/mxcube
HWR_REPO=${GIT_PATH}/mxcube/HardwareRepository
SUBMODULE="HardwareRepository"
CONFIG_REPO=${GIT_PATH}/bl13_mxcube_config
DEST=${HOME}/production

# Start deployment
echo "*** Deploying MXCuBE ***"

# Test if there are local changes in the production folder (it is a git repo)
pushd ${DEST} > /dev/null
  if [[ ! -z "$(git status --untracked-files=no --porcelain)" ]]; then
    echo "Local changes found in production folder. Aborting!"
    exit -1
  fi
popd > /dev/null

# Start deploying the mxcube project (mxcube + hwrepo + bl13_config)
for REPO in ${MX3_REPO} ${HWR_REPO} ${CONFIG_REPO}
do
  pushd ${REPO} > /dev/null
    ${DEPLOY_SCRIPT} ${DEST}
  popd > /dev/null
done

# Create a link from mxcube/HardwareRepository to HardwareRepository deployed
pushd ${DEST}/mxcube > /dev/null
  rm -r ${SUBMODULE}
  DEPLOYED_HWR=`readlink -f $DEST/HardwareRepository`
  ln -s ${DEPLOYED_HWR} ${SUBMODULE}
popd > /dev/null

# Commit deployed files
pushd ${DEST}> /dev/null
  echo "Committing deployed version"
  git add .
  git commit -m'New version deployed' > /dev/null
  echo "*** Done ***"
popd > /dev/null
