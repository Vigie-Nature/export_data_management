# export_data_management

Ce projet vise à importer, filtrer et standardiser les exports "à plat" des données des différents observatoires de Vigie-Nature pour ensuite les uploader vers l'espace serveur du MESU

Les étapes de l'envoi d'un export standardisé des données d'un observatoire sont les suivantes :

1.  **Importer** les données sous un dataframe dans l'environnement global, les filtrer et les standardiser
2.  **Tester** si l'export de données est conforme au standard défini dans les règles de contribution avec la fonction `check_data`
3.  **Uploader** l'export de données vers le serveur avec la fonction `upload_to_serve`

## Requirements

Chaque export de données s'effectue grâce à une fonction dédiée

Le script correspondant doit permettre d'effectuer les tâches suivantes :

-   **Importer le jeu de données** comme dataframe dans l'environnement gobal R

-   **Standardiser les noms des champs** là où nécessaire afin d'homogénéiser les exports (session, observation, user, etc...) et appliquer les formatages nécessaires (ex : format de dates en `YYYY-MM-DD`)

-   Corriger les problèmes de **valeurs aberrantes** là où nécessaire (ex : dates de sessions antérieures au lancement de l'observatoire, remplacer les `"null"`/`"NULL"` en `NA`)

-   Appliquer et documenter les **filtres spécifiques à l'observatoire** (valeurs d'abondances aberrantes, taxons hors liste, anonymisation, observations en dehors du territoire de France hexagonale, occurrences à ne pas diffuser, etc...)

### Importer les données brutes

Import depuis un fichier .csv contenant un export de données "brutes" stocké dans le sous-répertoire `/data/input`.

Import des données via l'envoi d'une requête SQL (`/sql`) dans le cas de Vigie-Nature école ou des bases de données hébergées chez Mosaic

### Standardisation des exports

Homogénéisation des termes utilisés :

-   `session` correspond à la participation, c'est-à-dire l'application du protocole par une personne à un moment donné (une collection spipoll, un relevé Vigie-Flore, une partie Birdlab...). Une `session` d'observation doit systématiquement être associée à un identifiant unique (`session_id`) et à une date `session_date`, et parfois à une heure de début et de fin (`session_starting_time`)

-   `observation` correspond à l'observation d'un taxon, et est associé à un identifiant unique (`observation_id`). Une session peut comporter une ou plusieurs observations. Les exports à plat peuvent contenir des sessions "vides" : aucun organisme n'a été observé et le champ `observation_id` sera vide. 

-   `site` permet d'identifier le lieu où a été effectuée la session d'observation. Le site doit être associé à des coordonnées géographiques en WGS 84.

- `latitude` & `longitude` : les protocoles ne se basent pas sur la même unité spatiale d'échantillonnage (transect, point d'observation, quadrat...). Afin de faciliter la synthèse des données l'export à plat doit associer un couple de coordonnées XY à chaque session (barycentre de la ligne ou du polygone).

-   `taxon` fournit l'information sur l'organisme ou le groupe d'organisme observé. Le `taxon` peut-être associé à une valeur de comptage (`taxon_count`) qui peut être une abondance ou un nombre de contacts. Si la valeur décrite dans `taxon_count` n'est pas un nombre d'individus alors le type doit être spécifié dans un champ `taxon_count_description`. Les exports à plat peuvent contenir des sessions "vides" : aucun organisme n'a été observé et le champ `taxon` sera vide.

> [!CAUTION] CHAQUE EXPORT DE DONNEES DOIT COMPRENDRE L'ENSEMBLE DES CHAMPS CI-DESSOUS

Liste des noms des champs obligatoires

| Nom du champ | Description | Valeurs aberrantes |
|------------------|-----------------------------------|-------------------|
| session_id | Identifiant unique de la session d'observation | Ne peut être NA |
| session_date | Date de la session d'observation, au format YYYY-MM-DD | Ne peut être NA |
| observation_id | Identifiant unique de l'observation | Peut être NA si aucun organisme n'a été observée lors de la session |
| user_id | Identifiant unique de la personne ayant effectué l'observation | Ne peut être NA |
| taxon | Nom de l'espèce, du groupe d'espèce ou du type d'organisme observé | Peut être NA si aucun organisme n'a été observé lors de la session |
| longitude | Longitude du site d'observation (la valeur exacte pour un point d'observation, le centroïde pour un transect ou un polygone) | Ne peut être NA |
| latitude | Latitude du site d'observation (la valeur exacte pour un point d'observation, le centroïde pour un transect ou un polygone) | Ne peut être NA |

Formatage

-   `session_date` au format `YYYY-MM-DD`

-   si absente du jeu de données, ajouter la colonne `session_year` correspondant à l'année de la session

### Corrections

### Filtres spécifiques liés à l'observatoire

## Getting started

### Data base access

```         
## Install usethis package ----
install.packages("usethis")

## Open ~/.Renviron file ----
usethis::edit_r_environ()
```

Then add the access variables following this example

```         
# FTP ACCESS
FTP_USER=ftp-user
FTP_PASSWORD=ftp-psw
SITE_FTP=ftp-adress

# HTTPS ACCESS
HTTPS_USER=http-user
HTTPS_PASSWORD=http-psw
SITE_NAME=http-adress

# Vigie-Nature École ACCESS
BDD_VNE_HOST=bdd_vne_host
BDD_VNE_PORT=bdd_vne_post
BDD_VNE_NAME=VNbdd_vne_name
BDD_VNE_USER=bdd_vne_user   
BDD_VNE_MDP=bdd_vne_mdp
```

## Data available

### Vigie-Nature École data

-   ALAMER
-   Algues brunes et bigorneaux
-   Opération escargots
-   Lichens GO
-   Oiseaux des Jardins
-   Sauvages de ma Rue
-   Spipoll
-   Placettes à vers de terre
-   Participation data (all observations together in a single .csv, without the protocol specific data)
