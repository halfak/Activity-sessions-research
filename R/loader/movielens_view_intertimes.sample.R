source("env.R")
source("util.R")

load_movielens_view_intertimes.sample = tsv_loader(
    paste(DATA_DIR, "movielens_view_intertime.sample.tsv", sep="/"),
    "MOVIELENS_VIEW_INTERTIMES.SAMPLE"
)
