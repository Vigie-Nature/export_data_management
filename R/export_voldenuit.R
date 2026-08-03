# HEADER --------------------------------------------
#
# Author:     Pauline Guinet
# Copyright     Copyright 2026 - Pauline Guinet
# Email:      pauline.guinet@mnhn.fr
#
# Date:     2026-07-23
#
# Script Name:    R/export_voldenuit.R
#
# Script Description:   Création du dataframe des données historiques de opj
#
#
# ------------------------------------

setwd("C:/Users/pguinet01/Documents/Vol de Nuit data/Trektellen_vol_de_nuit")

library(dplyr)
library(readxl)
library(tidyverse)

export_voldenuit <- function(){
  
  # Les fichiers avec les données brutes sont à demander à Pauline Guinet
  
  #ouverture des fichiers
  counts <- read_excel("Trektellen_vol_de_nuit_counts_.xlsx")
  data <- read_excel("Trektellen_vol_de_nuit_data.xlsx")
  equipment <- read_excel("Trektellen_vol_de_nuit_equipment.xlsx")
  sites <- read_excel("Trektellen_vol_de_nuit_sites.xlsx")
  species <- read_excel("Trektellen_vol_de_nuit_species.xlsx")
  
  ### jointure des dataframes
  test <- left_join(counts, sites)
  test <- left_join(test, equipment)
  dataset <- left_join(data, species)
  dataset <- left_join(dataset, test)
  
  #renommer les champs pour standard vigie-nature
  colnames(dataset)
  
  dataset<- dataset |> dplyr::rename(session_date = date, 
                                     session_id = countid, 
                                     session_starting_time = start, 
                                     session_ending_time = stop, 
                                     latitude = lat, 
                                     longitude = lng, 
                                     taxon = scientific, 
                                     taxon_count = ncalls,
                                     number_of_birds = nbirds)
  
  #protection des données
  dataset <- dataset |> 
    select(-email)
  
  #ajout d'une colonne descriptive de la valeur de comptage
  dataset$taxon_count_description <- "number of calls"
  
  #ordonner les colonnes pour avoir les colonnes standardisées VN en premier
  dataset <- dataset |> 
    select(session_date, 
           session_id, 
           session_starting_time, 
           session_ending_time, 
           latitude, 
           longitude, 
           taxon, 
           taxon_count, 
           taxon_count_description, 
           number_of_birds,
           everything())
  
  return(dataset)
}




