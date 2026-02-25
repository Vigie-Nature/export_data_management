#' Export a plat des donnees ALAMER
#'
#' @description
#' La fonction permet d'extraire les donnees du protocole ALAMER de Plages Vivantes via une requete SQL
#'
#' @param x a `numeric` vector
#'
#' @return Assigne un `data.frame` dans l'environnement global avec l'ensemble des donnees ALAMER tel que configuré dans l'export a plat standard
#'
#' @export
#'
#' @examples
#' 

export_alamer <- function(){
  
  
  
  ## export a plat plages vivantes
  query <- read_sql_query(here::here("sql", "alamer_export_a_plat.sql"))
  dt_alamer <- import_from_mosaic(query,
                                  database_name = "spgp",
                                  force_UTF8 = TRUE)
  
  dt_alamer <- dt_alamer  %>%
    #ajout de la colonne pour l'annee de la session colonnes
    mutate(annee = lubridate::year(session_date)) %>%
    #conserver uniquement les données depuis 2018
    filter(lubridate::year(session_date) > 2018)
  
  assign("dt_alamer", dt_alamer, envir = .GlobalEnv)
  
}

