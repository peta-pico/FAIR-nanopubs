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

if [ -f doc-x/$1-extra.ttl ]; then
  cat doc-x/$1-extra.ttl $1.ttl.pre > $1.ttl.pre2
  mv $1.ttl.pre2 $1.ttl.pre
fi

(
  echo "# The content of this file is automatically extracted from $1.trig." ;
  echo "# Changes should be made in $1.trig.pre." ;
  echo "";
  cat $1.ttl.pre
) > $1.ttl

rm $1.ttl.pre

java -jar $WIDOCOJAR -rewriteAll -uniteSections -ontFile $1.ttl -outFolder doc/$1

if [ -d doc-x/$1 ]; then
  cp -r doc-x/$1 doc/
fi

if [ -f doc/$1/sections/description-en.html ]; then
  (
    awk '{if ($0 == "<!--DESCRIPTION SECTION-->") exit; print $0;}' doc/$1/index-en.html ;
    cat doc/$1/sections/description-en.html | sed -r 's_</?html>__g' ;
    awk '{if ($0 == "<!--DESCRIPTION SECTION-->") {p=1; next;} if (p==1 && $0 ~ /^<!--/) p=2; if (p==2) print $0;}' doc/$1/index-en.html
  ) > doc/$1/index-en.mod.html
  mv doc/$1/index-en.mod.html doc/$1/index-en.html
fi

if [ -f doc/$1/sections/introduction-en.html ]; then
  (
    awk '{if ($0 == "<!--INTRODUCTION SECTION-->") exit; print $0;}' doc/$1/index-en.html ;
    cat doc/$1/sections/introduction-en.html | sed -r 's_</?html>__g' ;
    awk '{if ($0 == "<!--INTRODUCTION SECTION-->") {p=1; next;} if (p==1 && $0 ~ /^<!--/) p=2; if (p==2) print $0;}' doc/$1/index-en.html
  ) > doc/$1/index-en.mod.html
  mv doc/$1/index-en.mod.html doc/$1/index-en.html
fi

if [ -f doc/$1/sections/overview-en.html ]; then
  (
    awk '{if ($0 == "<!--OVERVIEW SECTION-->") exit; print $0;}' doc/$1/index-en.html ;
    cat doc/$1/sections/overview-en.html | sed -r 's_</?html>__g' ;
    awk '{if ($0 == "<!--OVERVIEW SECTION-->") {p=1; next;} if (p==1 && $0 ~ /^<!--/) p=2; if (p==2) print $0;}' doc/$1/index-en.html
  ) > doc/$1/index-en.mod.html
  mv doc/$1/index-en.mod.html doc/$1/index-en.html
fi

if [ -f doc/$1/sections/references-en.html ]; then
  (
    awk '{if ($0 == "<!--REFERENCES SECTION-->") exit; print $0;}' doc/$1/index-en.html ;
    cat doc/$1/sections/references-en.html | sed -r 's_</?html>__g' ;
    awk '{if ($0 == "<!--REFERENCES SECTION-->") {p=1; next;} if (p==1 && $0 ~ /^<!--/) p=2; if (p==2) print $0;}' doc/$1/index-en.html
  ) > doc/$1/index-en.mod.html
  mv doc/$1/index-en.mod.html doc/$1/index-en.html
fi

