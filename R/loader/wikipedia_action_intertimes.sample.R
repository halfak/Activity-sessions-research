source("env.R")
source("util.R")

load_wikipedia_action_intertimes.sample = tsv_loader(
    paste(DATA_DIR, "wikipedia_action_intertime.sample.tsv", sep="/"),
    "WIKIPEDIA_ACTION_INTERTIMES.SAMPLE"
)
