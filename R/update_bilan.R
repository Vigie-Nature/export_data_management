#######
# Functions to update the csv with the metadata
#######

#' Create a new row of metadata from an export
#'
#' @param export the flat export of an observatory (must complete the checks)
#' @param export_name the name of the flat export
#'
#' @return a data frame which is a row containing the metadatas of export
#'
#' @examples
#' 
#' new_bilan_row(export_steli,"export_steli")
#' 
new_bilan_row <- function(export,export_name){
  nb_lignes <- nrow(export)
  nb_cols <- ncol(export)
  dates <- lubridate::ymd(export$session_date)
  date_premier_obs <- min(dates,na.rm = TRUE)
  date_dernier_obs <- max(dates,na.rm = TRUE)
  nb_participants <- group_by(export,user_id) |> summarise() |> nrow()
  nb_sessions <- n_distinct(export$session_id)
  derniere_maj <- Sys.time()
  df <- data.frame(export_name=export_name,
                   nb_lignes=nb_lignes,
                   nb_cols=nb_cols,
                   date_premier_obs=date_premier_obs,
                   date_dernier_obs=date_dernier_obs,
                   nb_participants=nb_participants,
                   nb_sessions=nb_sessions,
                   date_derniere_maj=derniere_maj)
  
  return(df)
}

#' Update or add a row of the metadata of an export in the metadata csv
#'
#' @description
#' La fonction permet de mettre à jour les données d'un export dans le csv de metadonnées.
#' Si il n'existe pas déjà, le csv de metadonnées est créé.
#' 
#' @param metadata_file the path of the metadata csv to update or create
#' @param export the flat export of an observatory (must complete the checks)
#' @param export_name the name of the flat export
#'
#' @return 
#'
#' @examples
#' 
#' update_bilan(export_steli,"export_steli", "export_bilan.csv")
#' 
update_bilan <- function(export, export_name, metadata_file = "export_bilan.csv"){
  browser()
  # update all metadata
  new_row <- new_bilan_row(export, export_name) %>%
  mutate(across(starts_with("date"), ~ as.Date(.x, format = "%Y-%m-%d")))
  
  # check that bilan already exist
  if (any(list_ftp_files() == metadata_file)){
    table <- download_from_ftp(metadata_file) %>%
    mutate(across(starts_with("date"), ~ as.Date(.x, format = "%Y-%m-%d")))
    same_export = table[,"export_name"] == new_row$export_name
    # check if metadata already exist
    # replace line
    if (any(same_export)){
      table[same_export, ] <- new_row
    # add line
    } else {
      table <- bind_rows(table, new_row)
    }

  } else {
    table <- new_row
  }
  
  write.csv(table, paste0("data/",metadata_file), row.names = FALSE)

  # send file to ftp
  upload_file_to_server(paste0("data/",metadata_file), "", "Vigie-Nature/")

}
