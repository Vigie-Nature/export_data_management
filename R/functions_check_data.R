
# Vérifier que les colonnes requises sont présentes
#' Title
#'
#' @param df 
#' @param required_colnames 
#'
#' @returns
#' @export
#'
#' @examples
check_columns <- function(df,
                          required_colnames = c(
                            "observation_id",
                            "session_date",
                            "session_id",
                            "session_starting_time",
                            "session_ending_time",
                            "session_duration",
                            "geometry",
                            "latitude",
                            "longitude",
                            "taxon",
                            "cd_nom",
                            "cd_ref",
                            "taxon_count",
                            "taxon_count_description",
                            "validation"
                          )) {
  # On récupère les noms de colonne du dataframe
  df_colnames = colnames(df)
  # On évalue s'il existe des colonnes manquantes par rapport aux colonnes requises
  missing_columns = setdiff(required_colnames, df_colnames)
  
  # S'il y a au moins une colonne manquante on renvoie un warning en affichant les colonnes manquantes
  if (length(missing_columns) > 0) {
    warning(sprintf(
      "Colonnes manquantes (%s) : %s",
      deparse(substitute(df)),
      paste(missing_columns, collapse = ",")
    ))
  }
  
}

# Vérification de la présence 
# - de la colonne session_date
# - de la présence de NA dans les données
# - du format des dates dans les données (format demandé : %Y-%m-%d)
#' Title
#'
#' @param df a dataframe
#'
#' @returns a boolean
#'
#' @examples
#' df1 = data.frame(session_date = c("2025-01-02", "2024-03-02"))
#' df2 = data.frame(a = "2021-01-01")
#' df3 = data.frame(session_date = "01-01-2021")
#' check_session_date_format(df1) # return TRUE
#' check_session_date_format(df2) # return FALSE + warning
#' check_session_date_format(df3) # return TRUE + warning
check_session_date_format <- function(df) {
  is.session_date = setdiff("session_date", colnames(df))
  if (length(is.session_date) != 0) {
    warning(sprintf(
      "Pas de colonne session_date présente (%s)",
      deparse(substitute(df))
    ))
    return(FALSE)
  }
  
  vec_session_date = df$session_date
  nb_dates_na = length(which(is.na(vec_session_date)))
  
  if (nb_dates_na != 0) {
    warning(sprintf(
      "NA dans la colonne session_date (%s) : %d / %d",
      deparse(substitute(df)),
      nb_dates_na,
      length(vec_session_date)
    ))
  }
  
  vec_session_date = vec_session_date[which(!is.na(vec_session_date))]
  nb_dates_bad_format = length(which(is.na(as.Date(vec_session_date, "%Y-%m-%d"))))
  
  if (length(nb_dates_bad_format) != 0) {
    warning(sprintf(
      "Dates au mauvais format (%s) : %d / %d",
      deparse(substitute(df)),
      nb_dates_bad_format,
      length(vec_session_date)
    ))
    # return(FALSE)
  }
  
  return(TRUE)
}

#' Title
#'
#' @param df a dataframe
#'
#' @returns a boolean
#'
#' @examples
check_session_date_bornes <- function(df) {
  if (check_session_date_format(df)) {
    min_date = min(df$session_date, na.rm = T)
    max_date = max(df$session_date, na.rm = T)
    
    if (min_date < "1950-01-01") {
      warning("Date minimale invalide (%s) : %s",
              deparse(substitute(df)),
              min_date)
      # return(FALSE)
    }
    
    if (max_date > Sys.time()) {
      warning("Date maximale invalide (%s) : %s",
              deparse(substitute(df)),
              max_date)
      # return(FALSE)
    }
    return(TRUE)
  }
  return(FALSE)
}

#' Title
#'
#' @param df 
#' @param colname 
#'
#' @returns
#' @export
#'
#' @examples
check_column_na <- function(df, colname = "session_id") {
  is.col = setdiff(colname, colnames(df))
  if (length(is.col) == 0) {
    nb_na = length(which(is.na(df[, colname])))
    if (nb_na > 0) {
      warning(sprintf(
        "NA dans la colonne %s (%s) : %d / %d",
        deparse(substitute(df)),
        colname,
        nb_na,
        nrow(df)
      ))
    }
  }
}

