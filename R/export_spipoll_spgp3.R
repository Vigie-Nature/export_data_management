export_spipoll <- function(){
  
  
  
  ## export a plat spipoll
  query <- read_sql_query(here::here("sql", "spipoll_export_a_plat_v3.sql"))
  dt_spipoll <- import_from_mosaic(query,
                                   database_name = "spgp_v3",
                                   force_UTF8 = TRUE)
  
  # import des donnees
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