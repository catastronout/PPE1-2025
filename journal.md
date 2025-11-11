# Journal de bord du projet encadré

## Pour le 01/10
J'ai bien compris les notions expliquées en cours :

- fichier
- dossier/répertoire
- arborescence
- racine
- dossier personnel
- dossier courant ou "de travail" (working directory)
- chemin absolu
- chemin relatif
- caractères de remplacement (jokers ou wildcards)

Je n'ai pas de question :) 

&rarr; Pas de difficulté particulière pour faire les exercices de tri dans l'arborescence donnée (pour les images, il n'y a pas que des noms de ville ; malheureusement, je n'ai pas eu le temps de chercher tous les noms pour tout classer correctement : par exemple, le répertoire "Berlin" contient également les fichiers commençant par "Berlinette", "Berlingot", "Berlinguer", "Berlino"...)

## Pour le 08/10

- Création du dépôt "PPE1-2025" sur GitHub
- Ajout du journal de bord 
- Récupération du dépôt depuis GitHub et synchronisation avec ma machine

### Exercice 2.b
- git fetch &rarr; git status
- git pull 

### Exercice 2.c
- git add journal.md
- git commit -m "message"
- git push

## Pour le 15/10

Pour des raisons médicales, je n'ai malheureusement pas pu assister au cours du 08/10. J'ai donc, dans un premier temps, rattrapé ce que j'avais raté.

Je me suis ensuite penchée sur la feuille d'exercices de la semaine.

### Exercice 1
Commandes utilisée :
- `cat`, pour lire tous les fichiers `.ann` d'un coup (`cat ann/2016/*/*.ann`)
- `grep`, pour ne sélectionner que le pattern 'Location' (`grep "Location"`)
- `wc` avec l'option `-l`, pour obtenir le nombre d'occurrences du mot "Location" dans les fichiers `.ann` des années 2016, 2017 puis 2018 (`wc -l`)
- Chaque commande est séparée par un pipe (`|`), qui fait le pont entre les différentes commandes : envoie la sortie de la commande précédente en entrée de la suivante.

```bash
echo "Nombre de lignes contenant 'Location' pour l'année 2016 :" 
cat ann/2016/*/*.ann | grep "Location" | wc -l

echo "Nombre de lignes contenant 'Location' pour l'année 2017 :"
cat ann/2017/*/*.ann | grep "Location" | wc -l

echo "Nombre de lignes contenant 'Location' pour l'année 2018 :"
cat ann/2018/*/*.ann | grep "Location" | wc -l
```

### Exercice 2.a
Reprise du script de l'exercice 1, et ajout des variables `$ANNEE` et `$TYPE` pour rendre le script personnalisable : possibilité d'indiquer l'année et le type souhaités au lancement du script ; par exemple : `bash compte_par_type.sh 2016 Location`.

Je me suis rendu compte que l'utilisation du `*` comme argument posait problème. À l'origine, j'avais choisi de définir ma variable `$1` comme suit : `$CHEMIN` et de mettre en argument le chemin entier vers les fichiers `.ann`. Cependant, la sortie affichait `0`. Une fois la variable `$1` modifiée en `$ANNEE`, je n'avais plus besoin du `*`, ce qui a réglé mon problème.

```bash
ANNEE=$1
TYPE=$2

cat ann/$ANNEE/*/*.ann | grep "$TYPE" | wc -l
```

Dans la seconde partie de l'exercice, en suivant la consigne, je n'ai créé qu'une seule variable : `$TYPE`. 
Pour reprendre la structure que j'avais choisie pour l'exercice 1, j'ai adapté le message imprimé pour prendre en compte la variable : `$TYPE` :

```bash
echo "Nombre de lignes contenant '$TYPE' pour l'année 2016 :"
```
répété trois fois, pour les années 2016, 2017 et 2018.

J'ai ensuite appelé le script `compte_par_type.sh`, avec l'argument '$TYPE' :

```bash
bash compte_par_type.sh 2016 $TYPE
```

Ce qui donne :

```bash
TYPE=$1

echo "Nombre de lignes contenant '$TYPE' pour l'année 2016 :"
bash compte_par_type.sh 2016 $TYPE

echo "Nombre de lignes contenant '$TYPE' pour l'année 2017 :"
bash compte_par_type.sh 2017 $TYPE

echo "Nombre de lignes contenant '$TYPE' pour l'année 2018 :"
bash compte_par_type.sh 2018 $TYPE
```

### Exercice 2.b

Pour cet exercice, j'ai commencé par définir les variables `$ANNEE`, `$MOIS` et `NB_LIEUX`.

Puis j'ai utilisé les commandes suivantes, dans cet ordre :
- `cat`, pour lire les fichiers `.ann` qui nous intéressent 
- `grep`, pour sélectionner le pattern `Location'
- `cut`, nous voulons récupérer les noms des lieux, qui se trouve dans la troisième colonne - utilisation de l'option `-f3` (pour colonne 3)
- `sort`, pour classer les villes par ordre alphabétique
- `uniq`, pour supprimer les lignes qui se répète ; l'option `-c` permet de compter les occurrences pour chaque lieu (en colonne 1)
- `sort`, pour classer les villes par ordre décroissant (grâce à l'option `-r`) - c'est la première colonne qui est prise en compte par défaut
- `head`, pour ne sélectionner que les x premières lignes de la liste (défini par la valeur passée en `$3`)

Ce qui donne :

```bash
ANNEE=$1
MOIS=$2
NB_LIEUX=$3

echo "Classement des lieux les plus cités"

cat ann/$ANNEE/$MOIS/*.ann | grep "Location" | cut -f3 | sort | uniq -c | sort -r | head -n $NB_LIEUX
```

### Exercice 3

Ajout de quelques tests et validation des arguments :

***Vérification pour l'année*** :

&rarr; Si le dossier correspondant à l'année rentrée en `$1` n'existe pas, l'indiquer à l'utilisateur et quitter le programme.

```bash
if [ ! -d "ann/$ANNEE" ];
then
    echo "Année invalide (dossier inexistant)"
    exit 1
fi
```

***Vérification pour le mois*** :

&rarr; Même chose que pour l'année

```bash
if [ ! -d "ann/$ANNEE/$MOIS" ];
then
    echo "Mois invalide (dossier inexistant)"
    exit 1
fi
```

***Vérifications pour le type*** :

- Est-ce qu'une valeur `$2` a été rentrée ?

&rarr; Si `$TYPE` est vide, l'indiquer à l'utilisateur et quitter le programme.

```bash
if [ -z "$TYPE" ];                                # -z = True si la chaîne est vide
then
    echo "Type invalide (vide)"
    exit 1
fi
```

- Le type rentré en argument existe-t-il ?

&rarr; Création d'une variable `$TYPES_EXISTANTS` contenant tous les types existants dans les fichiers `.ann`

&rarr; Si le type rentré par l'utilisateur n'est pas dans la liste de types existants, l'indiquer et quitter le programme

```bash
TYPES_EXISTANTS=$(cat ann/$ANNEE/*/*.ann | cut -f2 | cut -d' ' -f1 | sort -u)
if ! echo "$TYPES_EXISTANTS" | grep -q "$TYPE";
then
    echo "Type invalide (inexistant)"
    exit 1
fi
```

***Vérification pour le nombre de lieux*** :

&rarr; Si la valeur indiquée par l'utilisateur n'est pas un chiffre, lui indiquer et quitter le programme

&rarr; Utilisation d'une regex : 
- `^[0-9]+$` (= tous les chiffres possibles) 
- `=~` = opérateur de correspondance de regex
- `^` = début de la chaîne
- `[0-9]` = chiffres de 0 à 9
- `+` = un ou plusieurs
- `$` = fin de la chaîne

```bash 
if ! [[ "$NB_LIEUX" =~ ^[0-9]+$ ]];
then
    echo "Nombre de lieux invalide (doit être un entier)"
    exit 1
fi
```

### Exercice 4

Création d'une boucle `for` qui itère sur les années 2016, 2017 et 2018, pour indiquer le nombre de lignes contenant le mot 'Location' par année.


```bash
for ANNEE in 2016 2017 2018
do
    echo "Nombre de lignes contenant 'Location' pour l'année "$ANNEE""
    cat ann/$ANNEE/*/*.ann | grep "Location" | wc -l
done
```

&rarr; Reprend la base de l'exercice 1 :

```bash
cat ann/2016/*/*.ann | grep "Location" | wc -l
```

***Code à commenter*** :
```bash
#!/usr/bin/bash       #shebang

if [ $# - ne 1 ]      #si le nb d'arguments n'est pas égal à 1 (= ce script requiert 1 argument)
then
    echo " ce programme demande un argument"   #indiquer à l'utilisateur qu'il manque l'argument
    exit                                       #quitter le programme
fi

FICHIER_URLS = $1     #l'argument 1 correspond à un fichier d'urls

OK=0                  #initialise la variable OK sur 0
NOK=0                 #initialise la variable NOK sur 0

#Tant qu'il reste des lignes à lire
while read -r LINE ;  #read lit le fichier ligne par ligne ; -r est une option de read qui permet de ne pas interpréter les \ comme des caractères spéciaux ; chaque ligne est stockée dans la variable 
do
    echo " la ligne : $LINE "                     #lit la ligne
    if [[ $LINE =∼ ^https?:// ]]                  #si la ligne commence par 'http(s)://'
then
    echo "ressemble à une URL valide "            #indique que l'URL semble valide
    OK = $ ( expr $OK + 1)                        #incrémente la variable OK de 1
else                                              #sinon 
    echo " ne ressemble pas à une URL valide "    #indique que l'URL ne semble pas valide
    NOK = $ ( expr $NOK + 1)                      # incrémente la variable NOK de 1
fi

done < $FICHIER_URLS                              #indique le fichier en entrée
echo " $OK URLs et $NOK lignes douteuses"         #indique le nombre d'URLs valides et non valides
```

# Pour le 05/11

Pour cause médicale, je n'ai malheureusement pas pu assister au dernier cours ; j'ai donc commencé par rattraper ce que j'avais raté, avant de me pencher sur les exercices.

## Exercice 1

### Question 1
`cat` permet d'afficher un fichier en entier. Or, ici, nous cherchons à lire un fichier ligne par ligne (ce que permet la boucle while), afin d'y ajouter des informations avant et après chaque URL, sur la même ligne.

### Question 2
Pour transformer `urls/fr.txt` en paramètre de script, nous pouvons créer une variable `URL=$1` au début du script (qui correspond à un argument 1 à renseigner à chaque lancement du script), puis appeler la variable à la place : `done < "$URL"`

### Question 3 
Pour afficher le numéro de chaque ligne avant l'URL, j'ai initialisé une variable `n` que j'ai initialisée à `1` avant la boucle while. À chaque passage dans la boucle, j'affiche d'abord la valeur de `n`, puis j'incrémente cette variable avec `n=$((n+1))`. Dans la commande `echo`, j'utilise `\t` (avec l'option `-e`) pour insérer des tabulations entres les différentes valeurs :
```bash
echo -e "${n}\t${line}\t${CODE}\t${ENCODAGE}\t${NB_MOTS}"
``` 

## Exercice 2
Quelques problèmes que j'ai pu avoir :
- *301 (redirection)* : j'ai rajouté l'option `-L` à `curl` pour suivre les redirections et obtenir le code final (200)
- *429* : ajout d'un User-Agent (par défaut : `UA="Mozilla/5.0"`)
- *Nombre de mot affiché à la mauvaise place (=collé au début de chaque URL)* : causé a priori par `\r`, corrigé avec : `tr -d '\r'`

Commande avec création d'un `.tsv` en sortie : 
```bash
bash miniprojet/programmes/miniprojet.sh miniprojet/urls/fr.txt > miniprojet/tableaux/tableau-fr.tsv
```

# Pour le 12/11

J'ai commencé par rattraper le cours de mercredi dernier, que j'ai dû rater également...

Puis j'ai modifié mon script `miniprojet.sh` afin de remplacer la sortie en `tsv` par `html`.

J'ai également 
- modifier le test qui vérifie le nombre d'arguments (à présent, le script en demande deux),
- rajouter une ligne pour que '-' soit inscrit dans le tableau si le code HTTP renvoie "000",
- rajouter une ligne pour que '-' soit noté dans la colonne 'Nombre de mots' si le code HTTP et l'encodage = '-'