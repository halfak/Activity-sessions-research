source("env.R")
source("util.R")

load_wikimedia_event_intertimes.sample = tsv_loader(
    paste(DATA_DIR, "wikimedia_event_intertime.sample.tsv", sep="/"),
    "WIKIMEDIA_EVENT_INTERTIMES.SAMPLE"
)
