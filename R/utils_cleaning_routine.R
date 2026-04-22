#' format_site
#'
#' A function format site ID and filter site not in the format
#' @param df a `data.frame` containing site ID
#' 
#' @return
#' A `data.frame`. The same dataframe with site cleaned
#'
format_site <- function(df){
  
  # Format site with 5 characters to 6 by adding a 0 on the first position
  df$site <- stringr::str_pad(df$site, width = 6, side = "left", pad = "0")
  
  # Checking if other sites still no vaiable
  sites_non_valides <- df[!grepl("^\\d{6}$", df$site), ]$site
  cat(n_distinct(sites_non_valides), "sites where filtered out of the data frame\n")
  
  df <- df %>% filter(grepl("^\\d{6}$", site))
  
  # # Pas utile car spécifique au STOC par points et pas aux autres observatoires.
  # sites_non_valides <- df %>% 
  #   filter(!str_sub(point, -2) %in% sprintf("%02d", 1:10)) %>% select(site)
  # cat(n_distinct(sites_non_valides), "sites where filtered out of the data frame
  #     because of incorrect site names (expect values between 1 and 10)\n")
  # #Remove all sites 
  # df <- df %>% 
  #   filter(str_sub(point, -2) %in% sprintf("%02d", 1:10)) %>%
  #   mutate(point = as.integer(str_sub(point, -2)))
  return(df)
}

#' format_bird_species
#'
#' A function format the species column and filter species not in the format
#' Expected format is the 6 caracters 
#' eg COLPAL for Columba palumbus (Common wood pigeon, Pigeon Ramier)
#' @param df a `data.frame` containing the main dataframe
#' @param dfBirdName a `data.frame` containing the list of 
#' birdName and 6 caracter format
#' 
#' @return
#' A `data.frame`. The same dataframe with cleaned species
#'
format_bird_species <- function(df, dfBirdName){
 # Excluding invalid species : 
  # 1) does not have 6 characters format in upper case
  # 2) species not in in dfBirdName
  invalid_species <- df %>%
    filter(
      !grepl("^[A-Z]{6}$", species) |        # wrong format
      !species %in% dfBirdName$species        # not bird
    ) %>%
    distinct(species) %>%                    # keeping only unique
    pull(species)                           
  
  cat(length(invalid_species), "species were filtered out of the data frame\n")
  df <- df %>%
    filter(
      grepl("^[A-Z]{6}$", species) &         # good format
        species %in% dfBirdName$species         # is a bird
    )
  return(df)
}

#' adding_site_point_information
#'
#' A function to add information about longlat (longitude*lattitude) and first
#' and last year of survey for the site
#' 
#' @param df a `data.frame` containing the main dataframe
#' @param byPoint a `boolean` indicating if dataframe is by site (carré stoc)
#' or by point (10 points per site)
#' 
#' @return
#' A `data.frame`. The same dataframe with cleaned species
#'
adding_site_point_information <- function(df, byPoint = TRUE){
  vars_group <- if (byPoint) {
    c("site", "point")
  } else {
    "site"
  }
  df <- df %>%
    group_by(across(all_of(vars_group))) %>%
    mutate(
      if(!"longlat" %in% colnames(df)){
        longlat = longitude * latitude
      },
      first_year = min(year),
      last_year = max(year)
    ) %>%
    ungroup()
  
  return(df)
}


#' filter_years
#'
#' A function to filter data where `datta$year` >= `filterYear`
#' 
#' @param df a `data.frame` containing the main dataframe
#' @param filterYear a `intefer` explaning the first year to keep data
#' 
#' @return
#' A `data.frame`. The same dataframe keeping only years > `filterYear`
#'
filter_years <- function(df, filterYear){
  return(df <- df %>% filter(first_year >= filterYear))
}

#' create_code_habitat
#'
#' A function to add a column about the habitats described in `habitat_principal`
#' 
#' @param df a `data.frame` containing the main dataframe
#' 
#' @return
#' A `data.frame`. The same dataframe with a new column about habitat
#'
create_code_habitat <- function(df){
  df <- df %>%
    mutate(code_habitat = case_when(
      grepl("^D", habitat_principal) ~ "Agricole",    # Agricole
      grepl("^[AB]", habitat_principal) ~ "Foret",    # Forêt
      grepl("^E", habitat_principal) ~ "Urbain",      # Urbain
      grepl("^F", habitat_principal) ~ "Aquatique",   # Aquatique
      grepl("^C", habitat_principal) ~ "Landes",      # Pelouse, Marais, Landes
      grepl("^G", habitat_principal) ~ "Rocks",       # Rochers
      TRUE ~ NA_character_                                 # Autres non reconnus
    )) %>%
    group_by(site, point) %>%
    mutate(code_habitat_first = first(code_habitat[year == first_year])) %>%
    mutate(code_habitat_last = first(code_habitat[year == last_year]))
  
  return(df)
}


rename_for_stoc <- function(df){
  df <- df %>% 
    mutate(year = lubridate::year(data$session_date))%>%
    rename(
      site = carre_id,
      point = point_id,
      species = taxon_id
    )
  return(df)
}