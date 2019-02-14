#!/bin/bash

USAGE="$ ./make-large-htaccess.sh"

if [ ! -z $1 ]; then
  echo "Usage: $USAGE"; exit 1
fi

for D in principles metrics; do
  ./make-trusty.sh $D
  ./make-rewrite-rules.sh $D
done

./make-large-htaccess.sh
