library(sf)
library(tmap)

dt = 
territoires = c("Espalion", "Gabriac", "Rodelle")

# importer les contours administratifs depuis le site de l'ADEME (Regions, Departements, EPCI et communes dans le meme objet)
if(!exists("contours_geographiques"))
{
  contours_geographiques <- sf::read_sf("https://data-interne.ademe.fr/data-fair/api/v1/datasets/-ke-aibn0igvxh5ouk2anrmd/data-files/GEO_Territoires_RDEC.geojson")
  # conserver uniquement les territoires metropolitains
  contours_geographiques <- contours_geographiques %>% filter(!is.na(TERR_METR), TERR_METR == "O")
  # trasnformer le systeme de coordonnees en EPSG 4326
  contours_geographiques <- sf::st_transform(contours_geographiques, crs = 4326)
  # verifier la validite des geometries
  contours_geographiques <- sf::st_make_valid(contours_geographiques)
}

# creer un objet spatial avec l'ensemble des sessions, a partir des champs latitude et longitude
coords_sessions <- sf::st_as_sf(dt_birdlab_simple %>% 
                                  select(session_id, longitude, latitude) %>% 
                                  distinct(),
                                coords = c("longitude", "latitude"), crs = 4326)

# filtre sur les regions
contours_geographiques %>% filter(TERR_NOM %in% territoires)

contours_communes = contours_geographiques %>% filter(TERR_TYPE == "Commune")
contours_epci = contours_geographiques %>% filter(TERR_TYPE == "EPCI")
contours_dep = contours_geographiques %>% filter(TERR_TYPE == "Département")
contours_regions = contours_geographiques %>% filter(TERR_TYPE == "Région")

st_intersection(contours_dep, contours_regions)
tmap_mode("plot")

contours_geographiques$sessions <- st_intersects(contours_geographiques, coords_sessions) %>% lengths()
tmap_mode("plot")

tm_shape(contours_geographiques %>% filter(TERR_TYPE == "Région")) +
  tm_lines() +
  tm_shape(coords_sessions) +
  tm_symbols() +
  tm_crs("auto")
