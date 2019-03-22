#!/bin/bash

USAGE="$ scripts/publish.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

if [ ! -f $1.trig ]; then
  echo "File $1.trig does not exist"; exit 1
fi

if [ ! -f $1.index.trig ]; then
  echo "File $1.index.trig does not exist"; exit 1
fi

echo "Publishing $1.trig..."
scripts/np publish $1.trig

echo "Publishing $1.index.trig..."
scripts/np publish $1.index.trig

