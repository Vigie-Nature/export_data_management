#' Import sql file in R
#'
#' @param filepath the path of the query as sql file
#'
#' @return
#' @export
#'
#' @examples
#' 
#' read_sql_query("my_query")
#' 
#' 
read_sql_query <- function(filepath, encoding = "latin1"){
  con = file(filepath, "r", encoding = encoding)
  lines <- readLines(con, encoding = encoding)
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

#' Import data from the VNE database
#'
#' @param query an sql query specific to VNE database
#'
#' @returns a dataframe
#'
#' @examples
#' 
#' query <- read_sql_query(paste0("sql/alamer_VNE4.sql"))
#' imported_file <- import_from_VNE(query)

import_from_VNE <- function(query){
  readRenviron(".env")
  # load required package
  require("RPostgreSQL", quietly = TRUE)
  
  # define access parameters
  host = Sys.getenv("BDD_VNE_HOST")
  port = Sys.getenv("BDD_VNE_PORT")
  dbname = Sys.getenv("BDD_VNE_NAME")
  user = Sys.getenv("BDD_VNE_USER")
  password = Sys.getenv("BDD_VNE_MDP")
  
  # creates a connection to the postgres database
  # note that "con" will be used later in each connection to the database
  con <- DBI::dbConnect(RPostgres::Postgres(), dbname = dbname,
                        host = host, port = port,
                        user = user, password = password)
  on.exit(DBI::dbDisconnect(con))
  
  #get result from query
  df_VN <- DBI::dbGetQuery(con, query)
  
  return(df_VN)
}
