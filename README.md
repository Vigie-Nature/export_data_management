# export_data_management

This set of functions and scripts allows you to export data and store them to the VN server

## requirement

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