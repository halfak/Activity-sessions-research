source("env.R")
source("util.R")

load_cyclopath_event_intertimes = tsv_loader(
    paste(DATA_DIR, "cyclopath_event_intertime.tsv", sep="/"),
    "CYCLOPATH_event_INTERTIME.SAMPLE"
)
