#!/bin/bash

set -e

USAGE="$ scripts/make-test-index.sh"

if [ ! -z $1 ]; then
  echo "Usage: $USAGE"; exit 1
fi

LASTRELEASE=$(scripts/get-last-release-nr.sh test)

if [ -z $LASTRELEASE ]; then
  echo "No previous release found"
  LASTINDEXARG=""
else
  LASTINDEX=$(
    cat releases/test.index.$LASTRELEASE.trig \
    | egrep '^@prefix this:' \
    | tail -1 \
    | sed -r 's/.*<(.*)>.*/\1/'
  )
  echo "Supersedes index: $LASTINDEX"
  LASTINDEXARG="-x $LASTINDEX"
fi

echo "Making index..."
scripts/np mkindex \
  -u https://w3id.org/fair/test/np/index/ \
  -c https://orcid.org/0000-0002-1267-0234 \
  -t "Test nanopublications" \
  -l https://creativecommons.org/publicdomain/zero/1.0/ \
  $LASTINDEXARG \
  -o test.index.temp.trig \
  test.trig

scripts/np sign -o test.index.trig test.index.temp.trig
rm test.index.temp.trig