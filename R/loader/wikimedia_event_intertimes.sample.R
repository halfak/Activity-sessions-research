source("env.R")
source("util.R")

load_wikimedia_event_intertimes.sample = tsv_loader(
    paste(DATA_DIR, "wikimedia_event_intertime.sample.tsv", sep="/"),
    "WIKIMEDIA_EVENT_INTERTIMES.SAMPLE",
    function(dt){
        prev_count = dt[
            type=="mobile view" & intertime > 1500 & intertime < 2000,
            list(count = length(intertime)),
            user_id
        ]$count
        problem_ids = dt[
            type=="mobile view" & intertime > 750 & intertime < 1250,
            list(count = length(intertime)),
            user_id
        ][count > (mean(prev_count) + .5*sd(prev_count))]$user_id
        
        dt[
            !type=="mobile view" |
            !user_id %in% problem_ids
        ]
    }
)

load_wikimedia_event_intertimes.sample.no_cleanup = tsv_loader(
    paste(DATA_DIR, "wikimedia_event_intertime.sample.tsv", sep="/"),
    "WIKIMEDIA_EVENT_INTERTIMES.SAMPLE.NO_CLEANUP",
)
