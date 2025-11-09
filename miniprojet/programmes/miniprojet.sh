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
UA="Mozilla/5.0"

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
	ENCODAGE=$(curl -sIL -A "$UA" "$line" | tr -d '\r' | grep -i "charset" | head -n1 | cut -d= -f2)
	[[ -z "$ENCODAGE" ]] && ENCODAGE="-"
	NB_MOTS=$(curl -sL -A "$UA" "$line" | wc -w)
	
	echo "<tr>
			<td>${n}</td>
			<td>${line}</td>
			<td>${CODE}</td>
			<td>${ENCODAGE}</td>
			<td>${NB_MOTS}</td>
		</tr>"

	n=$((n+1))

done < "$URL"

echo "</table>"