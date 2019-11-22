#!/bin/bash

set -e

USAGE="$ scripts/release.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

if [ ! -f $1.trig ]; then
  echo "File $1.trig does not exist"; exit 1
fi

if [ ! -f $1.index.trig ]; then
  echo "File $1.index.trig does not exist"; exit 1
fi

LASTRELEASE=$(scripts/get-last-release-nr.sh $1)

if [ -z $LASTRELEASE ]; then
  NEWRELEASE=0
  echo "No previous release found; new release number: $NEWRELEASE"
else
  let NEWRELEASE=$LASTRELEASE+1
  echo "New release number: $NEWRELEASE"
fi

echo "Publishing $1.trig..."
scripts/np publish $1.trig

echo "Publishing $1.index.trig..."
scripts/np publish $1.index.trig

echo "Save new release $1.$NEWRELEASE in releases/"
cp $1.trig releases/$1.$NEWRELEASE.trig
cp $1.index.trig releases/$1.index.$NEWRELEASE.trig
