source("loader/aol_search_intertimes.sample.R")

intertimes = load_aol_search_intertimes.sample()

source('clustering.R')

svg("exploration/plots/aol_searches.svg", height=5, width=7)
plot_clusters(intertimes, clusters=2)
dev.off()
