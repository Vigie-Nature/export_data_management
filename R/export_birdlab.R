#' Export a plat des donnees de Birdlab
#'
#' @description
#' La fonction permet d'extraire les donnees de Birdlab via une requete SQL
#'
#' @param
#'
#' @return Un `data.frame` comprenant un export à plat des données Birdlab
#' Chaque ligne du tableau représente l'action d'une espèce
#'
#' @export
#'
#' @examples
#' 

export_birdlab <- function(){
  
  ## data birdlab
  query <- read_sql_query(here::here("sql", "birdlab_export_a_plat.sql"))
  dt_birdlab <- import_from_mosaic(query,
                                   database_name = "birdlab",
                                   force_UTF8 = TRUE)
  # spécifier l'annee, le mois, et preciser un numero de saison, comme la participation s'étale sur l'hiver entre deux années
  dt_birdlab <- dt_birdlab %>% mutate(session_year = lubridate::year(session_date),
                                      session_month = lubridate::month(session_date),
                                      saison = ifelse(session_month %in% c(11,12),
                                                      session_year-2014+1,
                                                      ifelse(session_month %in% c(1,2,3),
                                                             session_year-2014,
                                                             NA)))
  # retirer les oiseaux sans heure d'arrivee
  dt_birdlab <- dt_birdlab %>%
    group_by(session_id, numero_individu) %>%
    mutate(has_arrivee = any(action %in% c("arrivée sur la mangeoire gauche",
                                           "arrivée sur la mangeoire droite"))) %>%
    ungroup() %>%
    filter(has_arrivee == TRUE) %>%
    select(-has_arrivee)
  
  
  # spliter la colonnes coordonnees en latitude et longitude
  dt_birdlab <- dt_birdlab %>% 
    tidyr::separate_wider_delim(mangeoires_coordonnees_gps, delim = ", ", names = c("longitude", "latitude"))
  
  # retirer les coordonnees NA ou [0, 0]
  dt_birdlab <- dt_birdlab %>% filter(!is.na(dt_birdlab$longitude))
  dt_birdlab <- dt_birdlab %>% filter(dt_birdlab$latitude != 0 & dt_birdlab$longitude != 0)
  
  return(dt_birdlab)
}

#' Simplification des donnees de Birdlab en listes d'especes sans les mouvements
#'
#' @description
#' La fonction permet de simplifier les donnees de l'observatoire, en synthétisant l'information
#' pour ne conserver qu'une liste d'espèces et un nombre d'individus associés 
#' On ne tient plus compte des actions de déplacement, simplement de l'espèce observée et des numeros des oiseaux
#' 
#' @param x un `data.frame` contenant l'export à plat complet des données Birdlab
#'
#' @return Un `data.frame` comprenant un export à plat des données Birdlab simplifié
#' où chaque ligne du tableau correspond à une observation d'une espèce et un nombre d'individus différents
#'
#' @export
#'
#' @examples
#' 

simplification_birdlab <- function(x){
  
  dt_birdlab <- x %>% group_by(session_id, taxon) %>%
    mutate(taxon_count = n_distinct(numero_individu)) %>%
    ungroup() %>%
    select(!c(numero_individu, action, seconde)) %>%
    distinct()
  
  return(dt_birdlab)

  }


