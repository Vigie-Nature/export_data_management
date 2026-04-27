#!/usr/bin/env Rscript

library(tidyr, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(stringr, quietly = TRUE)

# Charger les fonctions utiles
source(here::here("R", "function_import_from_mosaic.R"))
source(here::here("R", "function_encoding_utf8.R"))
source(here::here("R", "functions_ftp.R"))
source(here::here("R", "upload_file_to_server.R"))

# Charger la configuration
config <- data.table::fread(here::here("config.csv"), na.strings = c(NA_character_, ""))

# Lire les variables d'environnement
readRenviron(".Renviron")

config <-
  config |>
  filter(importer == 1)

for (i in attr(config, "row.names")) {
  conf <- config[i]
  nom_observatoire <- conf$observatoire
  nom_jeu <- conf$jeu
  nom_complet <- str_glue("{nom_observatoire}_{nom_jeu}")

  cat(str_glue("Jeu de données \"{nom_jeu}\" de l'observatoire \"{nom_observatoire}\":"), "\n")

  # Importation de données
  # (depuis une BDD distante ou depuis un fichier local)
  # La fonction doit s'appeler import_nom_observatoire dans le fichier
  # R/import_nom_observatoire.R
  cat(" - Importation des données", "\n")
  source(str_glue("R/import/{nom_observatoire}.R"))
  import_function <- get(str_glue("import_{nom_complet}"))
  data <- import_function()
  cat("Données importées avec succès", "\n")

  cat(" - Sauvegarde du jeu de données en local", "\n")
  readr::write_excel_csv2(data, here::here("data", str_glue("export_{nom_complet}.csv")))
  cat(str_glue("Données sauvegardées avec succès (fichier 'data/export_{nom_complet}.csv')"), "\n")

  cat(" - Standardisation des données", "\n")

  cat(" - Vérification des données", "\n")

  # Upload du jeu de données vers le FTP
  cat(" - Exportation vers le FTP", "\n")
  upload_file_to_server(
    file_to_upload = str_glue("export_{nom_complet}.csv"),
    file_folder_local = "data/",
    file_folder_destination = "Vigie-Nature/"
  )
  cat("Données exportées avec succès", "\n\n")
}
