#' Export a plat des donnees Vigie-Flore
#'
#' @description
#' La fonction permet de lire les données Vigie-Flore à partir d'un fichier csv transmis (contact ania.schleicher@mnhn.fr)
#' 
#' @param pathfile a string
#'
#' @return Assigne un `data.frame` dans l'environnement global avec l'ensemble des donnees Vigie-Flore tel que configuré dans l'export a plat standard
#' Chaque ligne du tableau représente une observation
#'
#'
#' @examples
#' dt_vigieflore = export_vigieflore("mypathtofile/export_vigieflore.csv")

library(dplyr)

export_vigieflore <- function(pathfile){

  dt_vf = read.csv2(pathfile, sep = ",")


  # Formatage des dates
  dt_vf = dt_vf %>%
    dplyr::rename(longitude = long_maille,
                  latitude = lat_maille,
                  session_zip_code = cd_departement,
                  insee_code = cd_INSEE) %>%
    dplyr::mutate(session_date = strftime(as.Date(session_date), "%Y-%m-%d"),
                  session_year = strftime(as.Date(session_date), "%Y"),
                  geometry = paste0("POINT(", longitude, " ", latitude, ")")) %>%
    dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "NULL"))) %>%
    dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "null"))) %>%
    dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")))

  # Filtre sur les requirements
  dt_vf = dt_vf %>%
    dplyr::filter(!is.na(session_id),
                  !is.na(session_date),
                  !is.na(longitude),
                  !is.na(latitude))

  # Filtre spécifique
  dt_vf = dt_vf %>%
    dplyr::filter(session_date > "2006-01-01",
                  is.na(ne.pas.diffuser))

  return(dt_vf)

}