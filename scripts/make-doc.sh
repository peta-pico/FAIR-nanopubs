#!/bin/bash

set -e

USAGE="$ scripts/make-doc.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

WORKINGDIR=`pwd`
cd "$( dirname "${BASH_SOURCE[0]}" )"
SCRIPTDIR=`pwd`
cd $WORKINGDIR

WIDOCOJAR=$(find $SCRIPTDIR -maxdepth 1 -name "widoco-*-jar-with-dependencies.jar" 2>/dev/null | sort -n | tail -1)

if [ -z "$WIDOCOJAR" ]; then
  echo "ERROR: Failed to find Widoco jar file. Run get-widoco.sh first."
  exit 1
fi

$SCRIPTDIR/np op extract -a -o $1.ttl.pre $1.trig

(
  echo "# The content of this file is automatically extracted from $1.trig." ;
  echo "# Changes should be made in $1.trig.pre." ;
  echo "";
  cat $1.ttl.pre
) > $1.ttl

rm $1.ttl.pre

java -jar $WIDOCOJAR -rewriteAll -ontFile $1.ttl -outFolder doc/$1
