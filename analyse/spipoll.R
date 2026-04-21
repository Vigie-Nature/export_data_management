# Extraction donnees Spipoll
source(here::here("R", "export_spipoll.R"))

# donnees de participation
dt_spipoll <- export_spipoll()

# Ecrire les donnees en csv
readr::write_csv2(dt_spipoll, here::here("data", "export_spipoll.csv"))

# envoyer les fichiers sur le serveur en FTP
upload_file_to_server(file_to_upload = "export_spipoll.csv", 
                      file_folder_local = "data/", 
                      file_folder_destination = "Vigie-Nature/")

# donnees d'interactions entre participants
spipoll_social_events <- export_spipoll_social_events()

# Ecrire les donnees en csv
readr::write_csv2(spipoll_social_events, here::here("data", "spipoll_comments.csv"))

# envoyer les fichiers sur le serveur en FTP
upload_file_to_server(file_to_upload = "spipoll_comments.csv", 
                      file_folder_local = "data/", 
                      file_folder_destination = "Vigie-Nature/")