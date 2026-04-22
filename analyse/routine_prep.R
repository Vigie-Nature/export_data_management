library(stringr)
library(dplyr)
library(data.table)
source("R/functions_ftp.R")
source("R/utils_cleaning_stoc.R")

# readRenviron(".env")
# list_ftp_files()
# x <- download_from_ftp(nom_fichier = "export_stoc.csv")
# write.csv(x, file = "data_stoc.csv")

# dataPath <- "/home/ferdinand/workplace/indicatorroutine/data/STOC_2024_latest/STOC_point_cleaned_2001_2024.csv"
data <- data.table::fread(file = "data_stoc.csv", encoding = "Latin-1", header = TRUE)
# data <- data.frame(data)
birdList <- data.table::fread("/home/ferdinand/workplace/indicatorroutine/speciesName.csv", header = TRUE)

dim(data)
#Variable à définir
start_year <- 2001

test <- rename_for_stoc(data)
dim(test)
test <- format_site(test)
test <- format_bird_species(test, birdList)
test <- adding_site_point_information(test, byPoint = TRUE)

data <- filter_years(data, start_year)
data <- create_code_habitat(data)
