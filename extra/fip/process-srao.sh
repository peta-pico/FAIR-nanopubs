#!/usr/bin/env bash

rapper -i rdfxml -o ntriples SRAO.owl \
  | awk '{
           if ($2 == "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>" &&
               $3 == "<http://www.w3.org/2002/07/owl#Class>") {
             s=$1;
           }
           if ($2 == "<http://www.w3.org/2000/01/rdf-schema#label>" && $1 == s) {
             print;
           }
         }' \
  > srao-labels.ttl
