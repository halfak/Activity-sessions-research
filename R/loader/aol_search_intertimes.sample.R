source("env.R")
source("util.R")

load_aol_search_intertimes.sample = tsv_loader(
    paste(DATA_DIR, "aol_search_intertime.sample.tsv", sep="/"),
    "AOL_SEARCH_INTERTIMES.SAMPLE"
)
