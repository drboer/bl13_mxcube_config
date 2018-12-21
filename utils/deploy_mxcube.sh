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
GITDIR=$HOME/git
DEPLOYER=$HOME/staging/MXCuBE-devel/bl13_config/utils/deploy_from_git.sh
MXCUBE_REPO=$GITDIR/mxcube
HWREPO_REPO=$GITDIR/mxcube/HardwareRepository
CONFIG_REPO=$GITDIR/bl13_mxcube_config
DEST=$HOME/production

# Start deploying the mxcube project (mxcube + hwrepo + bl13_config)
for REPO in $MXCUBE_REPO $HWREPO_REPO $CONFIG_REPO
do
  pushd $REPO > /dev/null
    $DEPLOYER $DEST
  popd > /dev/null
done

# Create a link from mxcube/HardwareRepository to HardwareRepository deployed
SUBMODULE="HardwareRepository"
pushd $DEST/mxcube > /dev/null
  rm -r $SUBMODULE
  DEPLOYED_HWREPO=`readlink -f $DEST/HardwareRepository`
  ln -s $DEPLOYED_HWREPO $SUBMODULE
popd > /dev/null
