#' Export a plat des donnees de l'opération papillons
#'
#' @description
#' La fonction permet d'extraire les donnees de spj via une requete SQL
#'
#' @param
#'
#' @return Un `data.frame` des données spj
#' Chaque ligne du tableau représente un taxon observé lors d'une session
#'
#' @export
#'
#' @examples
#' 

library(dplyr)

export_spj <- function(){
  # requete export a plat Spipoll
  query <- read_sql_query(here::here("sql", "spj_export_a_plat_standard.sql"))
  # import des donnees
  dt_spj <- import_from_mosaic(query, 
                               database_name = "spgp",
                               force_UTF8 = TRUE)
  
  # Modification du data frame
  dt_spj <- dt_spj %>%
    filter(filter(!is.na(dept_code),         # suppression des départements nuls
           str_length(dept_code)==2,  # suppression des drom-com
           session_year >= 2019) %>%
    # On passe la date en format YYYY-MM-DD
    mutate(session_date = as.Date(session_date, "%Y-%m-%d"))
    
  return(dt_spj)
}
