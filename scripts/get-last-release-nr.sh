#!/bin/bash

set -e

USAGE="$ scripts/get-last-release-nr.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

(ls releases/$1.*.trig \
  | grep -v index \
  | sed -r 's_releases/[a-z]*\.([0-9]+)\.trig_\1_' ) \
  | sort -nr \
  | head -1 \
  2> /dev/null
