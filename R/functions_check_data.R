
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
      "Pour %s \n Colonnes manquantes : %s",
      deparse(substitute(df)),
      paste(missing_columns, collapse = ",")
    ))
  }
  
}

# On vérifie le format des dates 
#' Title
#'
#' @param df 
#'
#' @returns
#' @export
#'
#' @examples
check_session_date_format <- function(df) {
  is.session_date = setdiff("session_date", colnames(df))
  if (length(is.session_date) == 0) {
    warning(sprintf(
      "Pas de colonne session_date présente dans le dataframe %s",
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
  nb_dates_bad_format = length(which(!is.na(as.Date(vec_session_date, "%Y-%m-%d"))))
  
  if (length(nb_dates_bad_format) != 0) {
    warning(sprintf(
      "Dates au mauvais format (%s) : %d / %d",
      deparse(substitute(df)),
      nb_dates_bad_format,
      length(vec_session_date)
    )
    return(FALSE)
  }
  
}

