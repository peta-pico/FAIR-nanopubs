#!/bin/bash

USAGE="$ ./make-trusty.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

if [ ! -f $1.trig.pre ]; then
  echo "File $1.trig.pre does not exist"; exit 1
fi

if [ `command -v np` ]; then
  NP='np' 
else
  ./get-nanopub-jar.sh
  NP='java -jar nanopub.jar' 
fi

echo "Processing $1.trig.pre..."
$NP mktrusty -o $1.trig $1.trig.pre

if [ -f make-$1-index.sh ]; then
  ./make-$1-index.sh
fi
