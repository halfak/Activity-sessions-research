source('loader/osm_changeset_intertimes.sample.R')

changesets = load_osm_changeset_intertimes.sample(reload=T)

source("clustering.R")

changesets_fit = fit_intertimes(
    changesets$intertime,
    clusters=c("within", "between", "extended_break")
)

svg("clusters/plots/inter-activity_time.osm_changesets.svg", height=5, width=7)
plot_clusters(
    changesets$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=changesets_fit
)
dev.off()


svg("clusters/plots/threshold_roc.osm_changesets.svg", height=5, width=7)
plot_roc(
    changesets$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=changesets_fit
)
dev.off()

svg("clusters/plots/true_and_false_positives.osm_changesets.svg",
    height=5, width=7)
plot_true_and_false_positives(
    changesets$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=changesets_fit
)
dev.off()

svg("clusters/plots/true_and_false_positive_difference.osm_changesets.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    changesets$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=changesets_fit
)
dev.off()
