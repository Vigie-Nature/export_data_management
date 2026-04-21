#' Export a plat des donnees de florilèges
#'
#' @description
#' La fonction permet d'extraire les donnees de florilèges via une requete SQL
#'
#' @param
#'
#' @return Un `data.frame` des données florilèges
#' Chaque ligne du tableau représente un taxon observé lors d'une session
#'
#' @export
#'
#' @examples
#' 

library(dplyr)
library(sf)

export_florileges <- function(){

  ## data noctambules
  query <- read_sql_query(here::here("sql", "florileges_export_a_plat_standard.sql"))
  dt_florileges <- import_from_mosaic(query,
                                  database_name = "espaces_verts",
                                  force_UTF8 = TRUE)
  
  # Calcul des centroïdes des sites pour latitude/longitude
  site_geo = dt_florileges$site_geometry
  # On identifie les sites dont les géométries sont en NA ou NULL
  test_geo = if_else(is.na(site_geo) | is.null(site_geo), FALSE, TRUE)
  # On identifie les sites parmi les restants qui n'ont pas une géométrie valide
  test_geo[which(test_geo)] = st_is_valid(st_as_sfc(site_geo[which(test_geo)], crs = 4326))
  # Les latitudes et longitudes des sites sont initialisées en NA
  site_longitude = NA
  site_latitude = NA
  # Pour les géométries valides on calcule la longitude...
  site_longitude[which(test_geo)] = st_coordinates(st_centroid(st_make_valid(st_as_sfc(site_geo[which(test_geo)], crs = 4326))))[,1]
  # ...et la latitude
  site_latitude[which(test_geo)] = st_coordinates(st_centroid(st_make_valid(st_as_sfc(site_geo[which(test_geo)], crs = 4326))))[,2]

  # Modification du data frame pour ajouter les colonnes manquantes
  dt_florileges <- dt_florileges |>
    # On commence par calculer la durée qui est calculée en nombre de secondes
    mutate(session_duration = as.numeric(difftime(as.POSIXct(session_ending_time, format="%H:%M:%S"),
                                      as.POSIXct(session_starting_time, format="%H:%M:%S"),
                                      units = "secs")),
          # Ajout des longitudes et latitudes pour les sites...
          longitude = site_longitude,
          latitude = site_latitude)
  
  return(dt_florileges)
  
}