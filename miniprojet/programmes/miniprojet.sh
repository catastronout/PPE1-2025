#!/bin/bash

# === UTILISATION == 
# bash miniprojet/programmes/miniprojet.sh miniprojet/urls/fr.txt > miniprojet/tableaux/tableau-fr.tsv

URL=$1

if (( $# != 1 )); 
then
	echo "Il manque un argument : le fichier texte contenant les URLs !"
	exit 1
fi

n=1

while read -r line;
do
	UA="Mozilla/5.0"

	CODE=$(curl -sL -A "$UA" -o /dev/null -w "%{http_code}\n" "$line")
	ENCODAGE=$(curl -sIL -A "$UA" "$line" | tr -d '\r' | grep -i "charset" | head -n1 | cut -d= -f2)
	[[ -z "$ENCODAGE" ]] && ENCODAGE="-"
	NB_MOTS=$(curl -sL -A "$UA" "$line" | wc -w)
	echo -e "${n}\t${line}\t${CODE}\t${ENCODAGE}\t${NB_MOTS}"
	n=$((n+1))
done < "$URL"
