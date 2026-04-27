library(stringr)

# Lire la configuration
source("config.R")

# Lire les variables d'environnement
readRenviron(".Renviron")

for (obs in observatoires) {
  # Importation de données
  # (depuis une BDD distante ou depuis un fichier local)
  # La fonction doit s'appeler import_nom_observatoire dans le fichier
  # R/import_nom_observatoire.R
  print(str_glue("Importation des données de {obs}"))
  source("R/import_{obs}.R")
  import_function <- get("import_{obs}")
  data <- import_function()

  print("Standardisation des données")

  print("Vérification des données")

  print("Exportation vers le FTP")

}
