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

echo "Making index..."
$NP mkindex \
  -u https://w3id.org/fair/principles/np/index/ \
  -a https://doi.org/10.1038/sdata.2016.18 \
  -c https://orcid.org/0000-0002-1267-0234 \
  -c https://orcid.org/0000-0003-4727-9435 \
  -t "Nanopublications representing the FAIR Principles" \
  -l http://creativecommons.org/licenses/by/4.0/ \
  -x https://raw.githubusercontent.com/FAIRDataInitiative/FAIR-principles/master/fair.trustyuri.trig#np.RA4FsMT1XSZMh-JgNmAuOVQ3qyTzkaMldT_KxR1HSdoUA \
  -o $1.index.trig \
  $1.trig
