source("env.R")
source("util.R")

load_movielens_search_intertimes.sample = tsv_loader(
    paste(DATA_DIR, "movielens_search_intertime.sample.tsv", sep="/"),
    "MOVIELENS_SEARCH_INTERTIMES.SAMPLE"
)
