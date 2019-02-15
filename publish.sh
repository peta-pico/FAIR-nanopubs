#!/bin/bash

USAGE="$ ./publish.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

if [ ! -f $1.trig ]; then
  echo "File $1.trig does not exist"; exit 1
fi

if [ ! -f $1.index.trig ]; then
  echo "File $1.index.trig does not exist"; exit 1
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

echo "Publishing $1.trig..."
$NP publish $1.trig

echo "Publishing $1.index.trig..."
$NP publish $1.index.trig

