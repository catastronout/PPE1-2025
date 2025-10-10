#!/usr/bin/bash

ANNEE=$1
TYPE=$2

# Vérifications pour l'année
if [ ! -d "ann/$ANNEE" ];                         # ! = négation ; -d = True si le dossier existe // si le dossier n'existe pas
then
    echo "Année invalide (dossier inexistant)"
    exit 1
fi

# Vérifications pour le type (vide)
if [ -z "$TYPE" ];                                # -z = True si la chaîne est vide
then
    echo "Type invalide (vide)"
    exit 1
fi

# Vérifications pour le type (inexistant)
TYPES_EXISTANTS=$(cat ann/$ANNEE/*/*.ann | cut -f2 | cut -d' ' -f1 | sort -u)      # création d'une variable contenant tous les types existants

if ! echo "$TYPES_EXISTANTS" | grep -q "$TYPE";   # recherche du type dans la liste des types existants
then
    echo "Type invalide (inexistant)"
    exit 1
fi

cat ann/$ANNEE/*/*.ann | grep "$TYPE" | wc -l