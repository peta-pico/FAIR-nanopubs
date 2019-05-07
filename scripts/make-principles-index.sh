#!/bin/bash

set -e

USAGE="$ scripts/make-principles-index.sh"

if [ ! -z $1 ]; then
  echo "Usage: $USAGE"; exit 1
fi

LASTRELEASE=$(scripts/get-last-release-nr.sh principles)

LASTINDEX=$(
  cat releases/principles.index.$LASTRELEASE.trig \
  | egrep '^@prefix this:' \
  | tail -1 \
  | sed -r 's/.*<(.*)>.*/\1/'
)

echo "Supersedes index: $LASTINDEX"

echo "Making index..."
scripts/np mkindex \
  -u https://w3id.org/fair/principles/np/index/ \
  -a https://doi.org/10.1038/sdata.2016.18 \
  -c https://orcid.org/0000-0002-1267-0234 \
  -c https://orcid.org/0000-0003-4727-9435 \
  -t "Nanopublications representing the FAIR Principles" \
  -l http://creativecommons.org/licenses/by/4.0/ \
  -x $LASTINDEX \
  -o principles.index.trig \
  principles.trig
