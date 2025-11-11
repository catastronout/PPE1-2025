#!/bin/bash

# === UTILISATION == 
# bash miniprojet/programmes/miniprojet.sh fr tableau-fr

FICHIER_URLS=$1
FICHIER_SORTIE=$2

if (( $# != 2 )); 
then
	echo "Ce script a besoin de deux arguments pour fonctionner !"
	exit 1
fi

n=1
UA="Mozilla/5.0"

{
echo "<table border=\"1\">
	<tr>
		<th>N°</th>
		<th>URL</th>
		<th>Code HTTP</th>
		<th>Encodage</th>
		<th>Nombre de mots</th>
	</tr>"

while read -r line;
do
	CODE=$(curl -sL -A "$UA" -o /dev/null -w "%{http_code}\n" "$line")
	[[ -z "$CODE" || "$CODE" == "000" ]] && CODE="-"

	ENCODAGE=$(curl -sIL -A "$UA" "$line" | tr -d '\r' | grep -i "charset" | head -n1 | cut -d= -f2)
	# Encodage UTF-8 = oui ou non 

	[[ -z "$ENCODAGE" ]] && ENCODAGE="-"

	NB_MOTS=$(curl -sL -A "$UA" "$line" | wc -w)
	# NB_MOTS=$(cat "tmp.txt" | lynx -dump -stdin -nolist | wc -w)
	if [[ "$CODE" == "-" && "$ENCODAGE" == "-" ]];
	then
		NB_MOTS="-"
	fi
	
	echo "<tr>
			<td>${n}</td>
			<td>${line}</td>
			<td>${CODE}</td>
			<td>${ENCODAGE}</td>
			<td>${NB_MOTS}</td>
		</tr>"

	n=$((n+1))

done < "../urls/$FICHIER_URLS.txt"

echo "</table>"
} > "../tableaux/$FICHIER_SORTIE.html"