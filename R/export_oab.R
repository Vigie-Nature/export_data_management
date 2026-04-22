#' Export a plat des donnees de l'OAB
#'
#' @description
#' La fonction permet d'extraire les données de l'OAB via une requete SQL
#'
#' @param x a `numeric` vector
#'
#' @return Un `data.frame` pour chacun des protocoles de l'OAB, tels que configurés pour les exports a plat standards
#' Chaque ligne du tableau représente soit une collection (session) vide sans organisme observé, soit une observation
#'
#' @export
#'
#' @examples
#'

export_qubs <- function(){

  # Liste des protocoles de l'OAB à exporter
  # Le protocole chiro est sur une autre base, à faire plus tard
  protocoles <- c(
    "nichoirs",
    "transects",
    "planches",
    "placettes"
  )

  for (proto in protocoles) {
    query <- read_sql_query(here::here("sql", stringr::str_glue("oab_{proto}.sql")))
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
        # Toutes les colonnes sauf taxon et abondance contiennent normalement
        # la même valeur (puisqu'on a fait un pivot_longer sans prendre ces
        # colonnes), donc on récupère cette valeur
        across(!c(taxon_count, taxon), first),
        taxon_count = sum(taxon_count)
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
    dt <-
      rbind(sessions_vides, observations) |>
      mutate(session_date = session_date |> lubridate::as_date() |> format(format = "%Y-%m-%d"))
      arrange(session_id)


    assign(
      stringr::str_glue("dt_{proto}"),
      dt_noctambules,
      envir = .GlobalEnv
    )

    readr::write_excel_csv2(dt, here::here("data", stringr::str_glue("export_oab_{proto}.csv")))

    upload_file_to_server(
      file_to_upload = stringr::str_glue("export_oab_{proto}.csv"),
      file_folder_local = "data/",
      file_folder_destination = "Vigie-Nature/"
    )
  }

}
