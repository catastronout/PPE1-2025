#!/usr/bin/bash

ANNEE=$1
MOIS=$2
NB_LIEUX=$3

# Vérifications pour l'année
if [ ! -d "ann/$ANNEE" ];                                   # ! = négation ; -d = True si le dossier existe // si le dossier n'existe pas
then
    echo "Année invalide (dossier inexistant)"
    exit 1
fi

# Vérifications pour le mois
if [ ! -d "ann/$ANNEE/$MOIS" ];                             # ! = négation ; -d = True si le dossier existe // si le dossier n'existe pas
then
    echo "Mois invalide (dossier inexistant)"
    exit 1
fi

# Vérifications pour le nombre de lieux
if ! [[ "$NB_LIEUX" =~ ^[0-9]+$ ]];                         # =~ = opérateur de correspondance de regex ; ^ = début de la chaîne ; [0-9] = chiffres de 0 à 9 ; 
                                                            # + = un ou plusieurs ; $ = fin de la chaîne
then
    echo "Nombre de lieux invalide (doit être un entier)"
    exit 1
fi

echo "Classement des lieux les plus cités"

cat ann/$ANNEE/$MOIS/*.ann | grep "Location" | cut -f3 | sort | uniq -c | sort -r | head -n $NB_LIEUX


# Exemple d'utilisation : 
# - bash compte_lieux.sh 2016 01 10
# - bash compte_lieux.sh "*" "*" 5