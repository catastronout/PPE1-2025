#!/usr/bin/bash

TYPE=$1

# Vérifications pour le type (vide)
if [ -z "$TYPE" ];                                # -z = True si la chaîne est vide
then
    echo "Type invalide (vide)"
    exit 1
fi

# Vérifications pour le type (inexistant)
TYPES_EXISTANTS=$(cat ann/*/*/*.ann | cut -f2 | cut -d ' ' -f1 | sort -u)      # création d'une variable contenant tous les types existants

if ! echo "$TYPES_EXISTANTS" | grep -qx "$TYPE";  # recherche du type dans la liste des types existants
then
    echo "Type invalide (inexistant)"
    exit 1
fi

echo "Nombre de lignes contenant '$TYPE' pour l'année 2016 :"
bash compte_par_type.sh 2016 $TYPE

echo "Nombre de lignes contenant '$TYPE' pour l'année 2017 :"
bash compte_par_type.sh 2017 $TYPE

echo "Nombre de lignes contenant '$TYPE' pour l'année 2018 :"
bash compte_par_type.sh 2018 $TYPE