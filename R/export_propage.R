#' Export a plat des donnees de propage
#'
#' @description
#' La fonction permet d'extraire les donnees de propage via une requete SQL
#'
#' @param
#'
#' @return Un `data.frame` des données propage
#' Chaque ligne du tableau représente un taxon observé lors d'une session
#'
#' @export
#'
#' @examples
#' 

library(dplyr)
library(sf)

export_propage <- function(){

  ## data noctambules
  query <- read_sql_query(here::here("sql", "propage_export_a_plat_standard"))
  dt_propage <- import_from_mosaic(query,
                                  database_name = "espaces_verts",
                                  force_UTF8 = TRUE)
  
  # Calcul des centroïdes des sites pour latitude/longitude
  site_geo = dt_propage$site_geometry
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

  # Calcul des latitudes et longitudes moyennes des transects
  # Fonction pour renvoyer la longitude (coord = 1) ou latitude (coord = 2) moyenne
  # d'une géométrie (value) encodée en json
  geo_fromJSON <- function(value, coord){
    return(mean(fromJSON(value)$coordinates[,coord], na.rm = TRUE))
  }
  # On récupère les géométries des transects
  transect_geo = dt_propage$transect_geometry
  # On applique la fonction pour récupérer les longitudes et latitudes
  transect_longitude = as.vector(sapply(transect_geo, geo_fromJSON, coord = 1))
  transect_latitude = as.vector(sapply(transect_geo, geo_fromJSON, coord = 2))

  # Modification du data frame pour ajouter les colonnes manquantes
  dt_propage <- dt_propage |>
    # On calcule la durée qui est calculée en secondes
    mutate(session_duration = as.numeric(difftime(as.POSIXct(session_ending_time, format="%H:%M:%S"),
                                      as.POSIXct(session_starting_time, format="%H:%M:%S"),
                                      units = "secs")),
          # Ajout des longitudes et latitudes pour les sites...
          site_longitude = site_longitude,
          site_latitude = site_latitude,
          # ...et pour les transects
          transect_longitude = transect_longitude,
          transect_latitude = transect_latitude)
  
  return(dt_propage)
  
}