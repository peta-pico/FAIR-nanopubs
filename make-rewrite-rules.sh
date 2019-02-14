#!/bin/bash

USAGE="$ ./make-rewrite-rules.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

if [ ! -f $1.trig ]; then
  echo "File $1.trig does not exist"; exit 1
fi

(
  echo "RewriteRule ^$1/terms/([^/]+)$ https://w3id.org/fair/principles/np/\$1/latest [R=302,L]";
  echo
) \
  > $1.htaccess

cat $1.trig \
  | grep '@prefix this:' \
  | sed -r 's/^@prefix this: <//' \
  | sed -r 's/> .$//' \
  | sed -r 's|^https://w3id.org/fair/([^/]+)/np/([^/]+)/([^/]+)$|RewriteRule ^\1/np/\2/latest$ http://app.petapico.d2s.labs.vu.nl/nanopub-server/\3 [R=302,L]|' \
  >> $1.htaccess
