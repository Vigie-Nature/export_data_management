library(stringr)
library(dplyr)
library(data.table)
source("R/utils_cleaning_routine.R")

#'routine_prep
#'
#' Fonction de setup a dataframe to minimal mandatory requirement to work on the
#' population trends routine dveloped in Vigie-Nature Cesco
#' @param df a `data.frame` containing the main dataframe
#' @param STOC a `boolean` indicating if the database is from STOC
#' @param byPoint a `logical` indicating whether observations are recorded at the
#' point level (i.e., multiple points nested within sites). If `FALSE`, data are
#' assumed to be aggregated at the site level.
#' @param start_year a `integer` indicating at which year the dataframe should start
#' 
#' @return
#' A `data.frame`. The same dataframe with a new column about habitat
#'
routine_prep <- function(data,
                         birdList,
                         STOC = FALSE,
                         byPoint = TRUE,
                         start_year = NULL)
{
  data <- rename_for_routine(data)
  data <- format_site(data)
  if(STOC){
    data <- format_bird_species(data, birdList)
    data <- create_code_habitat(data)
  }
  data <- adding_site_point_information(data, byPoint)
  
  data <- filter_years(data, start_year)
  
  return(data)
}

