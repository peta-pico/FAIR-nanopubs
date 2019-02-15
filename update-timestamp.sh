#!/bin/bash

USAGE="$ ./update-timestamp.sh principles"

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

TIMESTAMP=`$NP now`

echo "Setting timestamp $TIMESTAMP..."

cat $1.trig.pre \
  | sed -r 's/dct:created "[^"]*"\^\^xsd:dateTime/dct:created "'"$TIMESTAMP"'"^^xsd:dateTime/' \
  > $1.trig.pre.new

mv $1.trig.pre.new $1.trig.pre
