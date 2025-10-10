#!/usr/bin/bash

ANNEE=$1
TYPE=$2

cat ann/$ANNEE/*/*.ann | grep "$TYPE" | wc -l