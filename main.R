devtools::install_deps()
devtools::load_all()

library(dplyr)

# import environment variables
readRenviron(".env")

#load functions to fetch data
source(here::here("R", "function_import_from_mosaic.R"))
source(here::here("R", "function_encoding_utf8.R"))
source(here::here("R", "export_spipoll.R"))

export_spipoll()
export_spipoll_social_events()

export_qubs()
export_qubs_social_events()
