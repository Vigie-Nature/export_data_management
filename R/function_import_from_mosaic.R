#' Import sql file in R
#'
#' @param filepath the path of the query as sql file
#'
#' @return
#' @export
#'
#' @examples
#'
read_sql_query <- function(filepath){
  con = file(filepath, "r")
  lines <- readLines(con)
  for (i in seq_along(lines)){
    lines[i] <- gsub("\\t", " ", lines[i])
    if(grepl("--",lines[i]) == TRUE){
      lines[i] <- paste(sub("--","/*",lines[i]),"*/")
    }
  }
  sql.string <- paste(lines, collapse = " ")
  close(con)
  return(sql.string)
}



#' Import data from mosaic database
#'
#' @param query A sql query as string
#' @param database_name Database name as string
#'
#' @return Results from the query as dataframe
#' @export
#'
#' @examples
import_from_mosaic <- function(query, database_name, force_UTF8 = FALSE){
  library(RMySQL)

  # parameters
  db_user <- Sys.getenv('BDD_MOSAIC_USER')
  db_password <- Sys.getenv('BDD_MOSAIC_PASSWORD')
  db_host <- Sys.getenv('BDD_MOSAIC_HOST')
  db_port <- strtoi(Sys.getenv('BDD_MOSAIC_PORT'))

  # 3. Read data from db
  mydb <-  dbConnect(
    MySQL(),
    host = db_host,
    port = db_port,
    dbname = database_name,
    user = db_user,
    password = db_password
  )
  on.exit(dbDisconnect(mydb)) # Se déconnecter à la fin

  raw_query_result <- dbSendQuery(mydb, query)
  # Nettoyer la requête à la fin (_avant_ de fermer la connexion)
  # Permet d'éviter un message d'information
  on.exit(dbClearResult(raw_query_result), add = TRUE, after = FALSE)

  query_result <- dbFetch(raw_query_result, n = -1)

  #4. Force UTF8 encoding if column is char
  if(force_UTF8) {
    query_result <-
      query_result |>
      mutate_if(
        is.character,
        function(x) {
          Encoding(x) <- "UTF-8"
          return(x)
        }
      )
    }

  query_result
}
