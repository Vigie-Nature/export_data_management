#' Export a plat des donnees du Spipoll
#'
#' @description
#' La fonction permet d'extraire les donnees du Spipoll en via une requete SQL
#'
#' @param x a `numeric` vector
#'
#' @return Assigne un `data.frame` dans l'environnement global avec l'ensemble des donnees du Spipoll tel que configuré dans l'export a plat standard
#' Chaque ligne du tableau représente soit une collection (session) vide sans pollinisateur, soit une observation avec photo
#'
#' @export
#'
#' @examples
#' 

export_spipoll <- function(){



## export a plat spipoll
query <- read_sql_query(here::here("sql", "spipoll_export_a_plat.sql"))
dt_spipoll <- import_from_mosaic(query,
                                 database_name = "spgp",
                                 force_UTF8 = TRUE)

dt_spipoll <- dt_spipoll %>%
  #conserver uniquement les données depuis 2010
  filter(lubridate::year(session_date) > 2009) %>%
  #ajout de colonnes
  mutate(#annee de la session
    annee = lubridate::year(session_date),
    #colonne groupe taxonomique
    groupes = ifelse(insecte_ordre %in% c("Blattodea",
                                          "Dermaptera",
                                          "Mecoptera",
                                          "Neuroptera",
                                          "Opiliones",
                                          "Orthoptera",
                                          "Ephemeroptera",
                                          "Collembola",
                                          "Raphidioptera"), 
                     "Autres", 
                     NA))

# Modification des niveaux de facteur
dt_spipoll[which(dt_spipoll$insecte_ordre == "Diptera"),]$groupes <- "Diptères"
dt_spipoll[which(dt_spipoll$insecte_ordre == "Hymenoptera"),]$groupes <- "Hyménoptères"
dt_spipoll[which(dt_spipoll$insecte_ordre == "Coleoptera"),]$groupes <- "Coléoptères"
dt_spipoll[which(dt_spipoll$insecte_ordre == "Lepidoptera"),]$groupes <- "Lépidoptères"
dt_spipoll[which(dt_spipoll$insecte_ordre == "Hemiptera"),]$groupes <- "Hemiptères"
dt_spipoll[which(dt_spipoll$insecte_ordre == "Araneae"),]$groupes <- "Arachnides"
dt_spipoll[which(is.na(dt_spipoll$insecte_ordre)),]$groupes <- "Non attribué"

#remplacer les NAs par des zéros dans les champs 'protocole_long' et 'nb_validations'
dt_spipoll$protocole_long[is.na(dt_spipoll$protocole_long)] <- 0
dt_spipoll$nb_validation[is.na(dt_spipoll$nb_validation)] <- 0

#créer une colonne 'période" pour grouper les obs sur des périodes de 4 ans (à modifier dans l'argument breaks)
dt_spipoll <- dt_spipoll %>%
  mutate(periode = factor(cut(annee,
                              #Add 1 to the maximum value in dim to make sure it is included in the categorization.
                              breaks = c((seq(min(annee), max(annee), 4)), Inf),
                              #Set this to TRUE to include the lowest value
                              include.lowest = TRUE,
                              labels = FALSE,
                              #intervals are open on the right
                              right = FALSE)))

assign("dt_spipoll", dt_spipoll, envir = .GlobalEnv)

}

#' Export des interactions entre participants du Spipoll
#'
#' @description
#' La fonction permet d'extraire les donnees du Spipoll en via une requete SQL
#'
#' @param
#'
#' @return Un `data.frame` avec les interactions entre participants du Spipoll : notifications, échanges sur les observations (validations,
#' suggestions, ré-identifications, ajout de dénomination plus précise), et commentaires sur les sessions d'observation
#'
#' @export
#'
#' @examples
#' 

export_spipoll_social_events <- function(){

# importer les interactions entre participants du spipoll
query = read_sql_query(here::here("sql", "spipoll_social_events.sql"))
social_spipoll <- import_from_mosaic(query, database_name = "spgp", force_UTF8 = TRUE)
social_spipoll$typeId[which(social_spipoll$typeId == 1)] <- "Identification validée"
social_spipoll$typeId[which(social_spipoll$typeId == 2)] <- "Identification suggérée"
social_spipoll$typeId[which(social_spipoll$typeId == 3)] <- "Nouvelle identification de l'auteur"
social_spipoll$typeId[which(social_spipoll$typeId == 4)] <- "Commentaire"
social_spipoll$typeId[which(social_spipoll$typeId == 8)] <- "Notification"
social_spipoll$typeId[which(social_spipoll$typeId == 9)] <- "Ajout dénomination plus précise"

assign("social_spipoll", social_spipoll, envir = .GlobalEnv)

}