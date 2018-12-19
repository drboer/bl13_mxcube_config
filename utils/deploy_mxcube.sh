#!/usr/bin/env bash

PRODDIR=/homelocal/sicilia/production

ROOT=$(git rev-parse --show-toplevel)
echo $ROOT

if [[ $ROOT == *"fatal"* ]]; then
  echo "No repository!"
  exit -1
fi

NAME=$(basename $ROOT)
echo $NAME

if [[ $NAME != "mxcube" ]]; then
  echo "No mxcube repo"
  exit -1
fi

DEPLOY="/homelocal/sicilia/staging/MXCuBE-devel/bl13_config/utils/deploy_from_git.sh"

$DEPLOY $PRODDIR

HWREPDIR=$PRODDIR/"mxcube"

pushd "HardwareRepository"

  $DEPLOY $HWREPDIR

popd