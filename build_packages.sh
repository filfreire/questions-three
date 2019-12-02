#!/bin/bash

if test -z "$PYTHON"; then
  export PYTHON="python3"
fi

BASE_DIR="`pwd`"
DIST_DIR="$BASE_DIR/dist"

export QUESTIONS_THREE_MAJOR_VERSION=`cat setup.py | grep 'MAJOR_VERSION =' | awk '{print $3}'`
export QUESTIONS_THREE_MINOR_VERSION=`cat setup.py | grep 'MINOR_VERSION =' | awk '{print $3}'`
export QUESTIONS_THREE_PATCH_VERSION=`cat setup.py | grep 'PATCH_VERSION =' | awk '{print $3}'`

# We need to install questions-three so we can run unit tests on optional packages
if ! $PYTHON setup.py develop; then
  exit 1
fi

if ! $PYTHON setup.py test; then
  exit 1
fi

if ! $PYTHON setup.py bdist_wheel -d $DIST_DIR; then
  exit 1
fi

for PACKAGE_DIR in optional_packages/*; do
  echo "Building $PACKAGE_DIR"
  cd $BASE_DIR/$PACKAGE_DIR
  if ! $PYTHON setup.py test; then
    exit 1
  fi
  if ! $PYTHON setup.py bdist_wheel -d $DIST_DIR; then
    exit 1
  fi
done