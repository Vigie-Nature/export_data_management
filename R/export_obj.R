#' Export a plat des donnees de l'observatoire des bourdons
#'
#' @description
#' La fonction permet d'extraire les donnees de obj via une requete SQL
#'
#' @param
#'
#' @return Un `data.frame` des données obj
#' Chaque ligne du tableau représente un taxon observé lors d'une session
#'
#' @export
#'
#' @examples
#' 

library(dplyr)

export_obj <- function(){
  # requete export a plat Spipoll
  query <- read_sql_query(here::here("sql", "obj_export_a_plat_standard.sql"))
  # import des donnees
  dt_obj <- import_from_mosaic(query, 
                               database_name = "spgp",
                               force_UTF8 = TRUE)
  
  # Modification du data frame 
  dt_obj <- dt_obj %>%
    filter(filter(!is.na(dept_code),         # suppression des départements nuls
                  str_length(dept_code)==2,  # suppression des drom-com
                  session_year >= 2019) %>%
    # On passe la date en format YYYY-MM-DD
    mutate(session_date = as.Date(session_date, "%Y-%m-%d"))
    
  return(dt_obj)
}
