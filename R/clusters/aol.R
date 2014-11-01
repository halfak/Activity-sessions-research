source("loader/aol_search_intertimes.sample.R")

searches = load_aol_search_intertimes.sample()

source('clustering.R')

svg("clusters/plots/inter-activity_time.aol_searches.svg", height=5, width=7)
plot_clusters(searches$intertime, c("within", "between"))
dev.off()

svg("clusters/plots/threshold_roc.aol_searches.svg", height=5, width=7)
plot_roc(searches$intertime, c("within", "between"))
dev.off()

svg("clusters/plots/true_and_false_positives.aol_searches.svg",
    height=5, width=7)
plot_true_and_false_positives(searches$intertime, c("within", "between"))
dev.off()
