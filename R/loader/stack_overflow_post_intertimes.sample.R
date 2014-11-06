source("env.R")
source("util.R")

load_stack_overflow_post_intertimes.sample = tsv_loader(
    paste(DATA_DIR, "stack_overflow_post_intertime.sample.tsv", sep="/"),
    "STACK_OVERFLOW_POST_INTERTIMES.SAMPLE"
)
