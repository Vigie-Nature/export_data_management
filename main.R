devtools::install_deps()
devtools::load_all()

library(dplyr)

# import environment variables
readRenviron(".env")

#load functions to fetch data
source(here::here("R", "function_import_from_mosaic.R"))
source(here::here("R", "function_encoding_utf8.R"))
source(here::here("R", "upload_file_to_server.R"))


# Extraction donnees Qubs
source(here::here("R", "export_qubs.R"))
# donnees de participation
export_qubs()
# donnees d'interactions entre participants
export_qubs_social_events()
# envoyer les fichiers sur le serveur en FTP
upload_file_to_server(file_to_upload = "export_qubs_noctambules.csv", file_folder_local = "data/", file_folder_destination = "Vigie-Nature/")
upload_file_to_server(file_to_upload = "export_qubs_escargots.csv", file_folder_local = "data/", file_folder_destination = "Vigie-Nature/")
upload_file_to_server(file_to_upload = "export_qubs_aspifaune.csv", file_folder_local = "data/", file_folder_destination = "Vigie-Nature/")
upload_file_to_server(file_to_upload = "export_qubs_vers.csv", file_folder_local = "data/", file_folder_destination = "Vigie-Nature/")
upload_file_to_server(file_to_upload = "export_qubs_comments.csv", file_folder_local = "data/", file_folder_destination = "Vigie-Nature/")


# Extraction donnees Observatoire des Bourdons
source(here::here("R", "export_obj.R"))
# export a plat donnees hebdomadaires
dt_obj <- export_obj()
readr::write_excel_csv2(dt_obj, here::here("data", "export_obj.csv"))
# envoyer les fichiers sur le serveur en FTP
upload_file_to_server(file_to_upload = "export_obj.csv", file_folder_local = "data/", file_folder_destination = "Vigie-Nature/")


# Extraction donnees Opération papillons
source(here::here("R", "export_opj.R"))
# export a plat donnees hebdomadaires
dt_opj <- export_opj()
readr::write_excel_csv2(dt_opj, here::here("data", "export_opj.csv"))
# envoyer les fichiers sur le serveur en FTP
upload_file_to_server(file_to_upload = "export_opj.csv", file_folder_local = "data/", file_folder_destination = "Vigie-Nature/")


# Extraction donnees Birdlab
source(here::here("R", "export_birdlab.R"))
# export a plat donnees (complet avec actions des oiseaux)
dt_birdlab <- export_birdlab()
# ecrire l'export en csv en local
readr::write_excel_csv2(dt_birdlab, here::here("data", "export_birdlab.csv"))
# envoyer les fichiers sur le serveur en FTP
upload_file_to_server(file_to_upload = "export_birdlab.csv", 
                      file_folder_local = "data/", 
                      file_folder_destination = "Vigie-Nature/")
# simplification des données en listes d'espèces et nombre d'individus différents
dt_birdlab_simple <- simplification_birdlab(dt_birdlab)
# ecrire l'export en csv en local
readr::write_excel_csv2(dt_birdlab_simple, here::here("data", "export_birdlab_simple.csv"))
# envoyer les fichiers sur le serveur en FTP
upload_file_to_server(file_to_upload = "export_birdlab_simple.csv", 
                      file_folder_local = "data/", 
                      file_folder_destination = "Vigie-Nature/")


# Extraction donnees Alamer
source(here::here("R", "export_alamer.R"))
# donnees de participation
export_alamer()
