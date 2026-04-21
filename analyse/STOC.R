library(stringr)
library(dplyr)
source("R/utils_cleaning_stoc.R")

dataPath <- "/home/ferdinand/workplace/indicatorroutine/data/STOC_2024_latest/STOC_point_2001_2024.csv"
dataPath <- "/home/ferdinand/workplace/indicatorroutine/data/countingData.csv"
data <- data.table::fread(file = dataPath, encoding = "UTF-8", colClasses = c(site = "character"))
data <- data.frame(data)
birdList <- data.table::fread("/home/ferdinand/workplace/indicatorroutine/speciesName.csv", header = TRUE)


data <- format_site(data)
data <- format_bird_species(data, birdList)
data <- adding_site_point_information(data, byPoint = FALSE)
