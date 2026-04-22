new_bilan_row <- function(export,export_name){
  nb_lignes <- nrow(export)
  nb_cols <- ncol(export)
  dates <- lubridate::ymd(export$session_date)
  premier_obs <- min(dates,na.rm = TRUE)
  dernier_obs <- max(dates,na.rm = TRUE)
  nb_participants <- group_by(export,user_id) |> summarise() |> nrow()
  nb_sessions <- n_distinct(export$session_id)
  derniere_maj <- Sys.Date()
  df <- data.frame(export_name=export_name,
                   nb_lignes=nb_lignes,
                   nb_cols=nb_cols,
                   premier_obs=as.character(premier_obs),
                   dernier_obs=as.character(dernier_obs),
                   nb_participants=nb_participants,
                   nb_sessions=nb_sessions,
                   derniere_maj=as.character(derniere_maj))
  
  return(df)
}

update_bilan <- function(file,export,export_name){
  if (file.exists(file)){
    table <- read.csv(file)
  } else {
    table <- NULL
  }
  new_row <- new_bilan_row(export,export_name)
  
  # Add new_row to table
  same_export <- table[,"export_name"]==new_row$export_name
  if (sum(same_export)){
    table[same_export]=new_row
  } else {
    table <- bind_rows(table,new_row)
  }
  
  write.csv(table,file, row.names = FALSE)
}