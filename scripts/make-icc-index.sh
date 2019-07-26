#!/bin/bash

set -e

USAGE="$ scripts/make-icc-index.sh"

if [ ! -z $1 ]; then
  echo "Usage: $USAGE"; exit 1
fi

LASTRELEASE=$(scripts/get-last-release-nr.sh icc)

LASTINDEX=$(
  cat releases/icc.index.$LASTRELEASE.trig \
  | egrep '^@prefix this:' \
  | tail -1 \
  | sed -r 's/.*<(.*)>.*/\1/'
)

echo "Supersedes index: $LASTINDEX"

echo "Making index..."
scripts/np mkindex \
  -u https://w3id.org/fair/icc/np/index/ \
  -c https://orcid.org/0000-0001-8888-635X \
  -c https://orcid.org/0000-0002-1267-0234 \
  -c https://orcid.org/0000-0003-4818-2360 \
  -t "Nanopublications representing the FAIR Implementation Choices and Challenges Model" \
  -l https://creativecommons.org/publicdomain/zero/1.0/ \
  -x $LASTINDEX \
  -o icc.index.trig \
  icc.trig

