source("loader/enwiki_edit_intertimes.sample.R")

edits = load_enwiki_edit_intertimes.sample(reload=T)

source('clustering.R')


############################ Edit ##############################################
svg("clusters/plots/inter-activity_time.enwiki_edit.svg",
    height=5, width=7)
plot_clusters(
    edits[user_id != 5277842,]$intertime,
    clusters=c("within", "between", "extended_break")
)
dev.off()
