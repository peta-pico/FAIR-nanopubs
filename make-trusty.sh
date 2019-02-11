#!/bin/bash
#
# Usage:
#
# $ ./make-trusty.sh fair-principles
#

if [ ! -f nanopub.jar ]; then
  echo "Downloading nanopub.jar file..."
  wget -O nanopub.jar -nv https://github.com/Nanopublication/nanopub-java/releases/download/nanopub-1.19/nanopub-1.19-jar-with-dependencies.jar
fi

NP='java -jar nanopub.jar' 

echo "Processing $1.trig.pre..."
$NP mktrusty $1.trig.pre

echo "Post-processing result for $1.trig.pre..."
mv trusty.$1.trig.pre $1.trig
