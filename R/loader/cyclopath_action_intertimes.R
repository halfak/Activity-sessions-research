source("env.R")
source("util.R")

load_cyclopath_action_intertimes = tsv_loader(
    paste(DATA_DIR, "cyclopath_action_intertime.tsv", sep="/"),
    "CYCLOPATH_ACTION_INTERTIME.SAMPLE"
)
