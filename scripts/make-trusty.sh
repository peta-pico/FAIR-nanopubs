#!/bin/bash

USAGE="$ scripts/make-trusty.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

if [ ! -f $1.trig.pre ]; then
  echo "File $1.trig.pre does not exist"; exit 1
fi

echo "Processing $1.trig.pre..."
scripts/np mktrusty -o $1.trig $1.trig.pre

if [ -f scripts/make-$1-index.sh ]; then
  scripts/make-$1-index.sh
fi