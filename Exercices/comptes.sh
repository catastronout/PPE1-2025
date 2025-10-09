#!/usr/bin/bash

echo "Nombre de lignes contenant 'Location' pour l'année 2016 :" 
cat ann/2016/*/*.ann | grep "Location" | wc -l

echo "Nombre de lignes contenant 'Location' pour l'année 2017 :"
cat ann/2017/*/*.ann | grep "Location" | wc -l

echo "Nombre de lignes contenant 'Location' pour l'année 2018 :"
cat ann/2018/*/*.ann | grep "Location" | wc -l