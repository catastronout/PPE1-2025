#!/bin/bash

# echo "Nombre de lignes contenant 'Location' pour l'année 2016 :" 
# cat ann/2016/*/*.ann | grep "Location" | wc -l

# echo "Nombre de lignes contenant 'Location' pour l'année 2017 :"
# cat ann/2017/*/*.ann | grep "Location" | wc -l

# echo "Nombre de lignes contenant 'Location' pour l'année 2018 :"
# cat ann/2018/*/*.ann | grep "Location" | wc -l


for ANNEE in 2016 2017 2018
do
    echo "Nombre de lignes contenant 'Location' pour l'année "$ANNEE""
    cat ann/$ANNEE/*/*.ann | grep "Location" | wc -l
done