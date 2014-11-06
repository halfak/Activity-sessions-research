source("loader/wikipedia_action_intertimes.sample.R")

actions = load_wikipedia_action_intertimes.sample(reload=T)

source('clustering.R')

############################ Searches ##########################################
svg("clusters/plots/inter-activity_time.wikipedia_searches.svg",
    height=5, width=7)
plot_clusters(
    actions[type=="search"]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

svg("clusters/plots/threshold_roc.wikipedia_searches.svg", height=5, width=7)
plot_roc(
    actions[type=="search"]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

svg("clusters/plots/true_and_false_positives.wikipedia_searches.svg",
    height=5, width=7)
plot_true_and_false_positives(
    actions[type=="search"]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

svg("clusters/plots/true_and_false_positive_difference.wikipedia_searches.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    actions[type=="search"]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

############################ Desktop view ######################################
svg("clusters/plots/inter-activity_time.wikipedia_desktop_view.svg",
    height=5, width=7)
plot_clusters(
    actions[type=="desktop view"]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

svg("clusters/plots/threshold_roc.wikipedia_desktop_view.svg",
    height=5, width=7)
plot_roc(
    actions[type=="desktop view"]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

svg("clusters/plots/true_and_false_positives.wikipedia_desktop_view.svg",
    height=5, width=7)
plot_true_and_false_positives(
    actions[type=="desktop view"]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

svg("clusters/plots/true_and_false_positive_difference.wikipedia_desktop_view.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    actions[type=="desktop view"]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

############################ Mobile view ######################################
prev_count = actions[
    type=="mobile view" & intertime > 1500 & intertime < 2000,al
    list(count = length(intertime)),
    user_id
]$count
problem_ids = actions[
    type=="mobile view" & intertime > 750 & intertime < 1250,
    list(count = length(intertime)),
    user_id
][count > (mean(prev_count) + .5*sd(prev_count))]$user_id
mobile_view_fit = fit_intertimes(
    actions[type == "mobile view" & !user_id %in% problem_ids]$intertime,
    clusters=c("within", "between")
)
svg("clusters/plots/inter-activity_time.wikipedia_mobile_view.svg",
    height=5, width=7)
plot_clusters(
    actions[type == "mobile view"]$intertime,
    clusters=c("within", "between"),
    fit=mobile_view_fit
)
dev.off()

svg("clusters/plots/threshold_roc.wikipedia_mobile_view.svg",
    height=5, width=7)
plot_roc(
    actions[type=="mobile view"]$intertime,
    clusters=c("within", "between"),
    fit=mobile_view_fit
)
dev.off()

svg("clusters/plots/true_and_false_positives.wikipedia_mobile_view.svg",
    height=5, width=7)
plot_true_and_false_positives(
    actions[type=="mobile view"]$intertime,
    clusters=c("within", "between"),
    fit=mobile_view_fit
)
dev.off()

svg("clusters/plots/true_and_false_positive_difference.wikipedia_mobile_view.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    actions[type=="mobile view"]$intertime,
    clusters=c("within", "between"),
    fit=mobile_view_fit
)
dev.off()

############################ Search suggestion #################################

svg("clusters/plots/inter-activity_time.wikipedia_search_suggestion.svg",
    height=5, width=7)
plot_frequencies(
    actions[type=="search suggestion"]$intertime
)
dev.off()


############################ App view ##########################################

svg("clusters/plots/inter-activity_time.wikipedia_app_view.svg",
    height=5, width=7)
g = plot_frequencies(
    actions[type=="app view",]$intertime
)
g + scale_y_log10()
dev.off()

svg("clusters/plots/threshold_roc.wikipedia_app_view.svg",
    height=5, width=7)
plot_roc(
    actions[type=="app view"]$intertime,
    clusters=c("within", "between")
)
dev.off()

svg("clusters/plots/true_and_false_positives.wikipedia_app_view.svg",
    height=5, width=7)
plot_true_and_false_positives(
    actions[type=="app view"]$intertime,
    clusters=c("within", "between")
)
dev.off()

svg("clusters/plots/true_and_false_positive_difference.wikipedia_app_view.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    actions[type=="app view"]$intertime,
    clusters=c("within", "between")
)
dev.off()

############################ Edit ##############################################
svg("clusters/plots/inter-activity_time.wikipedia_edit.svg",
    height=5, width=7)
plot_clusters(
    actions[type=="edit",]$intertime,
    clusters=c("within", "between", "extended_break")
)
dev.off()

svg("clusters/plots/threshold_roc.wikipedia_edit.svg",
    height=5, width=7)
plot_roc(
    actions[type=="edit"]$intertime,
    clusters=c("within" "between", "extended_break")
)
dev.off()

svg("clusters/plots/true_and_false_positives.wikipedia_edit.svg",
    height=5, width=7)
plot_true_and_false_positives(
    actions[type=="edit"]$intertime,
    clusters=c("within" "between", "extended_break")
)
dev.off()

svg("clusters/plots/true_and_false_positive_difference.wikipedia_edit.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    actions[type=="edit"]$intertime,
    clusters=c("within" "between", "extended_break")
)
dev.off()
