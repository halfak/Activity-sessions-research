source("loader/enwiki_edit_intertimes.sample.R")

edits = load_enwiki_edit_intertimes.sample(reload=T)

source('clustering.R')


############################ Edit ##############################################
edit_fit = fit_intertimes(
    edits$intertime,
    clusters=c("within", "between", "extended_break")
)
svg("clusters/plots/inter-activity_time.enwiki_edit.svg",
    height=5, width=7)
plot_clusters(
    edits$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=edit_fit
)
dev.off()

cluster_intertimes = split_clusters(
    edits$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=edit_fit
)
