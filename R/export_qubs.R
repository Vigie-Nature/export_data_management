#' Export a plat des donnees de Qubs
#'
#' @description
#' La fonction permet d'extraire les donnees de chacun des protocoles de Qubs via des requetes SQL
#'
#' @param x a `numeric` vector
#'
#' @return Un `data.frame` comprenant un export à plat des données Birdlab
#' Chaque ligne du tableau représente l'action d'une espèce
#'
#' @export
#'
#' @examples
#' 

export_qubs <- function(){
  
  
  
  ## data noctambules
  query <- read_sql_query(here::here("sql", "qubs_export_a_plat_noctambules_standard.sql"))
  dt_noctambules <- import_from_mosaic(query,
                                   database_name = "qubs",
                                   force_UTF8 = TRUE)
  assign("dt_noctambules", dt_noctambules, envir = .GlobalEnv)
  readr::write_excel_csv2(dt_noctambules, here::here("data", "export_qubs_noctambules.csv"))
  
  ## data escargots
  query <- read_sql_query(here::here("sql", "qubs_export_a_plat_escargots_standard.sql"))
  dt_escargots <- import_from_mosaic(query,
                                     database_name = "qubs",
                                     force_UTF8 = TRUE)
  assign("dt_escargots", dt_escargots, envir = .GlobalEnv)
  readr::write_excel_csv2(dt_escargots, here::here("data", "export_qubs_escargots.csv"))
  
  ## data aspifaune
  query <- read_sql_query(here::here("sql", "qubs_export_a_plat_aspifaune_standard.sql"))
  dt_aspifaune <- import_from_mosaic(query,
                                     database_name = "qubs",
                                     force_UTF8 = TRUE)
  assign("dt_aspifaune", dt_aspifaune, envir = .GlobalEnv)
  readr::write_excel_csv2(dt_aspifaune, here::here("data", "export_qubs_aspifaune.csv"))
  
  ## data vers de terre
  query <- read_sql_query(here::here("sql", "qubs_export_a_plat_vers_de_terre_standard.sql"))
  dt_vers <- import_from_mosaic(query,
                                database_name = "qubs",
                                force_UTF8 = TRUE)
  assign("dt_vers", dt_vers, envir = .GlobalEnv)
  readr::write_excel_csv2(dt_vers, here::here("data", "export_qubs_vers.csv"))

}

#' Export des interactions entre participants de Qubs
#'
#' @description
#' La fonction permet d'extraire les donnees depuis la base de données Qubs en via une requete SQL
#'
#' @param
#'
#' @return Un `data.frame` avec les interactions entre participants de Qubs : notifications, échanges sur les observations (validations,
#' suggestions, ré-identifications, ajout de dénomination plus précise), et commentaires sur les sessions d'observation
#'
#' @export
#'
#' @examples
#' 

export_qubs_social_events <- function(){
  
  # recuperer les donnees des interactions sociales via la table qubs.comments
  query <- read_sql_query(here::here("sql", "qubs_social_events.sql"))
  qubs_social <- import_from_mosaic(query,
                                    database_name = "qubs",
                                    force_UTF8 = TRUE)
  
  # remplacer le type de ressource "participation" en "session" pour s'aligner sur le standard
  qubs_social[qubs_social$resource_type == "participation",]$resource_type <- "session"
  
  assign("qubs_social", qubs_social, envir = .GlobalEnv)
  readr::write_excel_csv2(qubs_social, here::here("data", "export_qubs_comments.csv"))
}