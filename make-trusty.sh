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
  if [ ! -f nanopub.jar ]; then
    echo "Downloading nanopub.jar file..."
    wget -O nanopub.jar -nv https://github.com/Nanopublication/nanopub-java/releases/download/nanopub-1.19/nanopub-1.19-jar-with-dependencies.jar
  fi
  NP='java -jar nanopub.jar' 
fi

echo "Processing $1.trig.pre..."
$NP mktrusty -o $1.trig $1.trig.pre

