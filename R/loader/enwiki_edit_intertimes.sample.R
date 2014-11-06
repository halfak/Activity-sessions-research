source("env.R")
source("util.R")

load_enwiki_edit_intertimes.sample = tsv_loader(
    paste(DATA_DIR, "enwiki_edit_intertime.sample.tsv", sep="/"),
    "ENWIKI_EDIT_INTERTIMES.SAMPLE"
)
