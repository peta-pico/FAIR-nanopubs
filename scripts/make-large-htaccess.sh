#!/bin/bash

set -e

USAGE="$ scripts/make-large-htaccess.sh"

if [ ! -z $1 ]; then
  echo "Usage: $USAGE"; exit 1
fi

(
  cat head.htaccess
  echo
  echo
  cat principles.htaccess
  echo
  echo
  cat icc.htaccess
) \
  > htaccess

