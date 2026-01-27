devtools::install_deps()
devtools::load_all()

library(dplyr)

# import environment variables
readRenviron(".env")

#load functions to fetch data
source(here::here("R", "function_import_from_mosaic.R"))
source(here::here("R", "function_encoding_utf8.R"))

# Extraction donnees Spipoll
source(here::here("R", "export_spipoll.R"))
# donnees de participation
export_spipoll()
# donnees d'interactions entre participants
export_spipoll_social_events()

# Extraction donnees Qubs
source(here::here("R", "export_qubs.R"))
# donnees de participation
export_qubs()
# donnees d'interactions entre participants
export_qubs_social_events()
