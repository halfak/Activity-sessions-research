source("loader/cyclopath_action_intertimes.R")

actions = load_cyclopath_action_intertimes(reload=T)

source("clustering.R")

############################## Selects #########################################
selects_fit = fit_intertimes(
    actions[type=="select",]$intertime,
    clusters=c("short_within", "long_within", "between")
)
svg("clusters/plots/inter-activity_time.cyclopath_selects.svg", height=5, width=7)
plot_clusters(
    actions[type=="select",]$intertime,
    clusters=c("short_within", "long_within", "between"),
    fit=selects_fit
)
dev.off()

svg("clusters/plots/threshold_roc.cyclopath_selects.svg", height=5, width=7)
plot_roc(
    actions[type=="select",]$intertime,
    clusters=c("short_within", "long_within", "between"),
    fit=selects_fit
)
dev.off()

svg("clusters/plots/true_and_false_positives.cyclopath_selects.svg",
    height=5, width=7)
plot_true_and_false_positives(
    actions[type=="select",]$intertime,
    clusters=c("short_within", "long_within", "between"),
    fit=selects_fit
)
dev.off()

svg("clusters/plots/true_and_false_positive_difference.cyclopath_selects.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    actions[type=="select",]$intertime,
    clusters=c("short_within", "long_within", "between"),
    fit=selects_fit
)
dev.off()


############################# Route Get ########################################
route_get_fit = fit_intertimes(
    actions[type=="route_get",]$intertime,
    clusters=c("within", "between")
)
svg("clusters/plots/inter-activity_time.cyclopath_route_gets.svg", height=5, width=7)
plot_clusters(
    actions[type=="route_get",]$intertime,
    clusters=c("within", "between"),
    fit=route_get_fit
)
dev.off()

svg("clusters/plots/threshold_roc.cyclopath_route_gets.svg", height=5, width=7)
plot_roc(
    actions[type=="route_get",]$intertime,
    clusters=c("within", "between"),
    fit=route_get_fit
)
dev.off()

svg("clusters/plots/true_and_false_positives.cyclopath_route_gets.svg",
    height=5, width=7)
plot_true_and_false_positives(
    actions[type=="route_get",]$intertime,
    clusters=c("within", "between"),
    fit=route_get_fit
)
dev.off()

svg("clusters/plots/true_and_false_positive_difference.cyclopath_route_gets.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    actions[type=="route_get",]$intertime,
    clusters=c("within", "between"),
    fit=route_get_fit
)
dev.off()
