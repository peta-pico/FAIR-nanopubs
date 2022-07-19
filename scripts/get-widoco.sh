#!/bin/bash

set -e

USAGE="$ scripts/get-widoco.sh"

if [ ! -z $1 ]; then
  echo "Usage: $USAGE"; exit 1
fi

cd scripts
wget https://github.com/dgarijo/Widoco/releases/download/v1.4.12/widoco-1.4.12-jar-with-dependencies.jar
