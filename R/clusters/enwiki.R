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


davies_boulin(
    edits$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=edit_fit
)

two_distr_fit = fit_intertimes(
    edits$intertime,
    clusters=c("within", "between")
)
davies_boulin(
    edits$intertime,
    clusters=c("within", "between"),
    fit=two_distr_fit
)


four_distr_fit = fit_intertimes(
    edits$intertime,
    clusters=c("short_within", "long_within", "between", "extended_break")
)
davies_boulin(
    edits$intertime,
    clusters=c("short_within", "long_within", "between", "extended_break"),
    fit=four_distr_fit
)
