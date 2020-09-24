#!/bin/bash

set -e

USAGE="$ scripts/make-fip-index.sh"

if [ ! -z $1 ]; then
  echo "Usage: $USAGE"; exit 1
fi

LASTRELEASE=$(scripts/get-last-release-nr.sh fip)

if [ -z $LASTRELEASE ]; then
  echo "No previous release found"
  LASTINDEXARG=""
else
  LASTINDEX=$(
    cat releases/fip.index.$LASTRELEASE.trig \
    | egrep '^@prefix this:' \
    | tail -1 \
    | sed -r 's/.*<(.*)>.*/\1/'
  )
  echo "Supersedes index: $LASTINDEX"
  LASTINDEXARG="-x $LASTINDEX"
fi

echo "Making index..."
scripts/np mkindex \
  -u https://w3id.org/fair/fip/np/index/ \
  -c https://orcid.org/0000-0003-2195-3997 \
  -c https://orcid.org/0000-0001-8888-635X \
  -c https://orcid.org/0000-0002-1267-0234 \
  -t "Nanopublications representing the FAIR Implementation Profiles (FIP) Ontology" \
  -l https://creativecommons.org/publicdomain/zero/1.0/ \
  $LASTINDEXARG \
  -o fip.index.trig \
  fip.trig

