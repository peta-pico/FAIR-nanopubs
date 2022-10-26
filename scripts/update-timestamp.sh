#!/bin/bash

set -e

USAGE="$ scripts/update-timestamp.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

if [ ! -f $1.trig.pre ]; then
  echo "File $1.trig.pre does not exist"; exit 1
fi

TIMESTAMP=$(scripts/np now)

echo "Setting timestamp $TIMESTAMP..."

cat $1.trig.pre \
  | sed -r 's_dct:created "[^"]*"\^\^xsd:dateTime_dct:created "'"$TIMESTAMP"'"^^xsd:dateTime_' \
  > $1.trig.pre.new

mv $1.trig.pre.new $1.trig.pre
