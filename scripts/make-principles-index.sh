#!/bin/bash

USAGE="$ scripts/make-principles-index.sh"

if [ ! -z $1 ]; then
  echo "Usage: $USAGE"; exit 1
fi

if [ `command -v np` ]; then
  NP='np' 
else
  scripts/get-nanopub-jar.sh
  NP='java -jar nanopub.jar' 
fi

echo "Making index..."
$NP mkindex \
  -u https://w3id.org/fair/principles/np/index/ \
  -a https://doi.org/10.1038/sdata.2016.18 \
  -c https://orcid.org/0000-0002-1267-0234 \
  -c https://orcid.org/0000-0003-4727-9435 \
  -t "Nanopublications representing the FAIR Principles" \
  -l http://creativecommons.org/licenses/by/4.0/ \
  -x https://raw.githubusercontent.com/FAIRDataInitiative/FAIR-principles/master/fair.trustyuri.trig#np.RA4FsMT1XSZMh-JgNmAuOVQ3qyTzkaMldT_KxR1HSdoUA \
  -o principles.index.trig \
  principles.trig
