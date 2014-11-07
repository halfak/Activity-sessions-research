source("env.R")
source("util.R")

load_movielens_event_intertimes.sample = tsv_loader(
    paste(DATA_DIR, "movielens_event_intertime.sample.tsv", sep="/"),
    "MOVIELENS_EVENT_INTERTIMES.SAMPLE"
)
