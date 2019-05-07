#!/bin/bash

set -e

USAGE="$ scripts/make-trusty.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

if [ ! -f $1.trig.pre ]; then
  echo "File $1.trig.pre does not exist"; exit 1
fi

echo "Processing $1.trig.pre..."
scripts/np mktrusty -r -o $1.temp.trig $1.trig.pre
