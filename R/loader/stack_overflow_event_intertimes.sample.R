source("env.R")
source("util.R")

load_stack_overflow_event_intertimes.sample = tsv_loader(
    paste(DATA_DIR, "stack_overflow_event_intertime.sample.tsv", sep="/"),
    "STACK_OVERFLOW_EVENT_INTERTIMES.SAMPLE"
)
