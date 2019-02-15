#!/bin/bash

USAGE="$ ./get-nanopub-jar.sh"

if [ ! -z $1 ]; then
  echo "Usage: $USAGE"; exit 1
fi

if [ ! -f nanopub.jar ]; then
  echo "Downloading nanopub.jar file..."
  wget -O nanopub.jar -nv https://github.com/Nanopublication/nanopub-java/releases/download/nanopub-1.19/nanopub-1.19-jar-with-dependencies.jar
fi
