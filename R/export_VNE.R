#  Send VNE data to the Vigie-Nature ftp

# import functions ----
source("R/functions_import_database_VN.R")
source("R/functions_ftp.R")


# list of the protocols to upload
protocoles_query <- c("alamer",
                      "escargots",
                      "oiseaux",
                      "sauvages",
                      "vdt",
                      "spipoll_VNE",
                      "biolit",
                      "lichens"
)

# import and process file loop ----
for (i in seq_along(protocoles_query)){
  cat(paste("Importation des données", protocoles_query[i]))
  
  # import file from database ----
  query <- read_sql_query(paste0("sql/", protocoles_query[i], "_VNE4.sql"))
  imported_file <- import_from_VNE(query)
  cat("       ok\n")
  
  # add missing columns or transform them to current format
  cat("add missing columns or transform")
  
  # add observation_id
  imported_file$observation_id <- seq_along(imported_file$session_id)
  
  # add geometry
  if (protocoles_query[i] == "sauvages"){
    coordinates = c("longitude_debut", "latitude_debut")
  } else {
    coordinates = c("longitude", "latitude")
  }
  
  imported_file_geometry = sf::st_as_sf(imported_file, coords = coordinates, 
                                        crs = 4326, agr = "constant")
  # add cd_nom / cd ref
  imported_file_geometry$cd_nom <- imported_file_geometry$cd_ref <- NA
  # add validation
  imported_file_geometry$validation = NA
  cat("       ok\n")
  
  # add information on the abondance index
  imported_file_geometry$taxon_count_description <- hutils::Switch(protocoles_query[i], DEFAULT = "abondance", 
                 "alamer" = "classe_abondance",
                 "spipoll_VNE" = "classe_abondance",
                 "lichens" = "classe_abondance",
                 "sauvages" = "presence")
  
  # save file
  dir.create("data")
  file_to_save_name <- paste0("data/export_vne_", protocoles_query[i], ".csv")
  data.table::fwrite(imported_file_geometry, file = file_to_save_name)
  # send the file
  upload_file_to_ftp(file_to_save_name, "", "Vigie-Nature/")
  # remove file after upload
  file.remove(file_to_save_name)
}
