#!/usr/bin/bash

TYPE=$1

echo "Nombre de lignes contenant '$TYPE' pour l'année 2016 :"
bash compte_par_type.sh 2016 $TYPE

echo "Nombre de lignes contenant '$TYPE' pour l'année 2017 :"
bash compte_par_type.sh 2017 $TYPE

echo "Nombre de lignes contenant '$TYPE' pour l'année 2018 :"
bash compte_par_type.sh 2018 $TYPE