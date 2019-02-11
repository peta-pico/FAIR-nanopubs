#!/bin/bash

if [ ! -f nanopub.jar ]; then
  echo "Downloading nanopub.jar file..."
  wget -O nanopub.jar -nv https://github.com/Nanopublication/nanopub-java/releases/download/nanopub-1.19/nanopub-1.19-jar-with-dependencies.jar
fi

NP='java -jar nanopub.jar' 

for F in *.pre; do
  echo "Processing $F..."
  $NP mktrusty $F
done

for F in trusty.*.pre; do
  echo "Post-processing result $F..."
  TEMP=${F#trusty.}
  N=${TEMP%.pre}
  mv $F $N
done
