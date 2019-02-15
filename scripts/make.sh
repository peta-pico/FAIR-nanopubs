#!/bin/bash

USAGE="$ scripts/make.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

scripts/update-timestamp.sh $1
scripts/make-trusty.sh $1
scripts/make-rewrite-rules.sh $1

scripts/make-large-htaccess.sh
