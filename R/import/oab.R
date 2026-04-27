#' Export a plat des donnees de l'OAB
#'
#' Les données exportés sont au format décrit dans la [documentation](https://vigie-nature.github.io/data_catalogue_vn/chapters/data-oab.html)
#' Chaque ligne du tableau représente soit une collection (session) vide sans organisme observé, soit une observation
#'
#' @description
#' La fonction permet d'extraire les données de l'OAB via une requete SQL
#'
#' @param protocole Un character string décrivant le protocole à exporter (doit être "nichoirs", "transects", "planches" ou "placettes")
#'
#' @return Un `data.frame` pour correspondant au protocole demandé
#'
import_oab <- function(protocole) {
  # Liste des protocoles de l'OAB
  protocoles <- c(
    "nichoirs",
    "transects",
    "planches",
    "placettes"
  )
  if (!protocole %in% protocoles) {
    stop(stringr::str_glue("Protocole {protocole} inconnu pour l'OAB"))
  }

  # Requête SQL
  query <- read_sql_query(here::here("sql", stringr::str_glue("oab_{protocole}.sql")))
  dt <- import_from_mosaic(
    query,
    database_name = "oab",
    force_UTF8 = TRUE
  )

  # On transforme toutes les colonnes qui correspondent à chaque taxon en lignes
  dt <-
    dt |>
    pivot_longer(
      starts_with("taxon_"),
      names_to = "taxon",
      names_prefix = "taxon_",
      values_to = "taxon_count"
    ) |>
    # Conversion en entier pour éviter un bug
    mutate(taxon_count = as.integer(taxon_count))

  # On récupère les sessions vides: les sessions dont la somme des abondances
  # est nulle, et on met taxon à NA dans ce cas
  sessions_vides <-
    dt |>
    summarise(
      .by = session_id,
      taxon_count = sum(taxon_count),
      # Toutes les colonnes sauf taxon et taxon_count contiennent normalement
      # la même valeur (puisqu'on a fait un pivot_longer sans prendre ces
      # colonnes), donc on récupère cette valeur
      across(!c(taxon_count, taxon), first)
    ) |>
    filter(taxon_count == 0) |>
    mutate(taxon = NA_character_, .before = taxon_count) |>
    mutate(taxon_count = NA_integer_) |>
    mutate(observation_id = NA_character_, .before = taxon)

  # On récupère les sessions non vides
  observations <-
    dt |>
    filter(taxon_count != 0) |>
    mutate(observation_id = stringr::str_glue("{session_id}_{taxon}"), .before = taxon)

  # Et on fusionne les deux
  data <-
    rbind(sessions_vides, observations) |>
    mutate(session_date = session_date |> lubridate::as_date() |> format(format = "%Y-%m-%d")) |>
    arrange(session_id)

  data
}

#' Export a plat des donnees nichoirs à abeilles solitaires de l'OAB
#'
#' @return Un `data.frame`
#'
import_oab_nichoirs <- function(protocole) {
  import_oab("nichoirs")
}

#' Export a plat des donnees transects à papillons de l'OAB
#'
#' @return Un `data.frame`
#'
import_oab_transects <- function(protocole) {
  import_oab("transects")
}

#' Export a plat des donnees planches à invertébrés de l'OAB
#'
#' @return Un `data.frame`
#'
import_oab_planches <- function(protocole) {
  import_oab("planches")
}

#' Export a plat des donnees placettes vers de terre de l'OAB
#'
#' @return Un `data.frame`
#'
import_oab_placettes <- function(protocole) {
  import_oab("placettes")
}
