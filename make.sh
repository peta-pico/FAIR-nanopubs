#!/bin/bash

USAGE="$ ./make.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

./update-timestamp.sh $1
./make-trusty.sh $1
./make-rewrite-rules.sh $1

./make-large-htaccess.sh
