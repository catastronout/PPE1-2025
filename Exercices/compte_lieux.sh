#!/usr/bin/bash

ANNEE=$1
MOIS=$2
NB_LIEUX=$3

echo "Classement des lieux les plus cités"

cat ann/$ANNEE/$MOIS/*.ann | grep "Location" | cut -f3 | sort | uniq -c | sort -r | head -n $NB_LIEUX

# Exemple d'utilisation : 
# - bash compte_lieux.sh 2016 01 10
# - bash compte_lieux.sh "*" "*" 5