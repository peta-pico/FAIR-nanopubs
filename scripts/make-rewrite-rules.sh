#!/bin/bash

set -e

USAGE="$ scripts/make-rewrite-rules.sh principles"

if [ -z $1 ] || [ ! -z $2 ]; then
  echo "Usage: $USAGE"; exit 1
fi

if [ ! -f $1.trig ]; then
  echo "File $1.trig does not exist"; exit 1
fi

(
  echo "RewriteCond %{HTTP_ACCEPT} text/html";
  echo "RewriteRule ^$1/terms/([^/]+)$ https://peta-pico.github.io/FAIR-nanopubs/$1/index-en.html#https://w3id.org/fair/$1/terms/\$1 [R=302,L,NE]";
  echo "RewriteRule ^$1/terms/([^/]+)$ https://w3id.org/fair/principles/latest/\$1 [R=302,L]";
  echo "RewriteRule ^$1/np/[^/]+/(RA[A-Za-z0-9_\\-]{43})$ http://np.inn.ac/\$1 [R=302,L]";
  echo
) \
  > $1.htaccess

cat $1.trig \
  | grep '^@prefix this:' \
  | sed -r 's/^@prefix this: <//' \
  | sed -r 's/> .$//' \
  | sed -r 's|^https://w3id.org/fair/([^/]+)/np/(.+)/([^/]+)$|RewriteRule ^\1/latest/\2$ http://np.inn.ac/\3 [R=302,L]|' \
  >> $1.htaccess

if [ ! -f $1.index.trig ]; then
  exit
fi

echo >> $1.htaccess

cat $1.index.trig \
  | grep '^@prefix this:' \
  | tail -1 \
  | sed -r 's/^@prefix this: <//' \
  | sed -r 's/> .$//' \
  | sed -r 's|^https://w3id.org/fair/([^/]+)/np/([^/]+)/([^/]+)$|RewriteRule ^\1/latest/\2$ http://np.inn.ac/\3 [R=302,L]|' \
  >> $1.htaccess
