source("loader/wikimedia_event_intertimes.sample.R")

wikimedia = load_wikimedia_event_intertimes.sample(reload=T)

source('clustering.R')

############################ Desktop view ######################################
desktop_fit = fit_intertimes(
    wikimedia[type=="desktop view"]$intertime,
    clusters=c("short_within", "long_within", "between")
)
svg("exploration/plots/inter-activity_time.wikimedia_desktop_view.svg",
    height=5, width=7)
plot_clusters(
    wikimedia[type=="desktop view"]$intertime,
    clusters=c("short_within", "long_within", "between"),
    fit=desktop_fit
)
dev.off()

svg("exploration/plots/threshold_roc.wikimedia_desktop_view.svg",
    height=5, width=7)
plot_roc(
    wikimedia[type=="desktop view"]$intertime,
    clusters=c("short_within", "long_within", "between"),
    fit=desktop_fit
)
dev.off()

svg("exploration/plots/true_and_false_positives.wikimedia_desktop_view.svg",
    height=5, width=7)
plot_true_and_false_positives(
    wikimedia[type=="desktop view"]$intertime,
    clusters=c("short_within", "long_within", "between"),
    fit=desktop_fit
)
dev.off()

svg("exploration/plots/true_and_false_positive_difference.wikimedia_desktop_view.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    wikimedia[type=="desktop view"]$intertime,
    clusters=c("short_within", "long_within", "between"),
    fit=desktop_fit
)
dev.off()

############################ Mobile view ######################################
prev_count = wikimedia[
    type=="mobile view" & intertime > 1500 & intertime < 2000,al
    list(count = length(intertime)),
    user_id
]$count
problem_ids = wikimedia[
    type=="mobile view" & intertime > 750 & intertime < 1250,
    list(count = length(intertime)),
    user_id
][count > (mean(prev_count) + .5*sd(prev_count))]$user_id
mobile_view_fit = fit_intertimes(
    wikimedia[type == "mobile view" & !user_id %in% problem_ids]$intertime,
    clusters=c("within", "between")
)
svg("exploration/plots/inter-activity_time.wikimedia_mobile_view.svg",
    height=5, width=7)
plot_clusters(
    wikimedia[type == "mobile view"]$intertime,
    clusters=c("within", "between"),
    fit=mobile_view_fit
)
dev.off()

svg("exploration/plots/threshold_roc.wikimedia_mobile_view.svg",
    height=5, width=7)
plot_roc(
    wikimedia[type=="mobile view"]$intertime,
    clusters=c("within", "between"),
    fit=mobile_view_fit
)
dev.off()

svg("exploration/plots/true_and_false_positives.wikimedia_mobile_view.svg",
    height=5, width=7)
plot_true_and_false_positives(
    actions[type=="mobile view"]$intertime,
    clusters=c("within", "between"),
    fit=mobile_view_fit
)
dev.off()

svg("exploration/plots/true_and_false_positive_difference.wikimedia_mobile_view.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    wikimedia[type=="mobile view"]$intertime,
    clusters=c("within", "between"),
    fit=mobile_view_fit
)
dev.off()

############################ App view ##########################################
app_view_fit = fit_intertimes(
    wikimedia[type=="app view"]$intertime,
    clusters=c("short_within", "long_within", "between")
)
svg("exploration/plots/inter-activity_time.wikimedia_app_view.svg",
    height=5, width=7)
plot_clusters(
    wikimedia[type == "app view"]$intertime,
    clusters=c("within", "between"),
    fit=app_view_fit
)
dev.off()

svg("exploration/plots/threshold_roc.wikimedia_app_view.svg",
    height=5, width=7)
plot_roc(
    wikimedia[type == "app view"]$intertime,
    clusters=c("within", "between"),
    fit=app_view_fit
)
dev.off()

svg("exploration/plots/true_and_false_positives.wikimedia_app_view.svg",
    height=5, width=7)
plot_true_and_false_positives(
    wikimedia[type == "app view"]$intertime,
    clusters=c("within", "between"),
    fit=app_view_fit
)
dev.off()

svg("exploration/plots/true_and_false_positive_difference.wikimedia_app_view.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    wikimedia[type == "app view"]$intertime,
    clusters=c("within", "between"),
    fit=app_view_fit
)
dev.off()

############################ Search suggestion #################################

#svg("exploration/plots/inter-activity_time.wikimedia_search_suggestion.svg",
#    height=5, width=7)
#plot_frequencies(
#    wikimedia[type=="search suggestion"]$intertime
#)
#dev.off()

############################ Searches ##########################################
#searches_fit = fit_intertimes(
#    wikimedia[type=="search"]$intertime,
#    clusters=c("short_within", "long_within", "between")
#)
#svg("exploration/plots/inter-activity_time.wikimedia_searches.svg",
#    height=5, width=7)
#plot_clusters(
#    wikimedia[type=="search"]$intertime,
#    clusters=c("short_within", "long_within", "between"),
#    fit=searches_fit
#)
#dev.off()
#
#svg("exploration/plots/threshold_roc.wikimedia_searches.svg", height=5, width=7)
#plot_roc(
#    wikimedia[type=="search"]$intertime,
#    clusters=c("short_within", "long_within", "between"),
#    fit=searches_fit
#)
#dev.off()
#
#svg("exploration/plots/true_and_false_positives.wikimedia_searches.svg",
#    height=5, width=7)
#plot_true_and_false_positives(
#    wikimedia[type=="search"]$intertime,
#    clusters=c("short_within", "long_within", "between"),
#    fit=searches_fit
#)
#dev.off()
#
#svg("exploration/plots/true_and_false_positive_difference.wikimedia_searches.svg",
#    height=5, width=7)
#plot_true_and_false_positive_difference(
#    actions[type=="search"]$intertime,
#    clusters=c("short_within", "long_within", "between"),
#    fit=searches_fit
#)
#dev.off()
