source("loader/movielens_action_intertimes.sample.R")

actions = load_movielens_action_intertimes.sample(reload=T)

source('clustering.R')

svg("exploration/plots/movielens_repeated_actions.svg", height=12, width=5)
ggplot(
    actions,
    aes(
        x = intertime
    )
) +
facet_wrap(~ type, ncol=1) +
geom_density(fill="#EEEEEE") +
theme_bw() +
scale_x_log10(
    "\nInter-activity time",
    breaks=c(
        5,
        60,
        7*60,
        60*60,
        24*60*60,
        7*24*60*60,
        30*24*60*60,
        356*24*60*60
    ),
    labels=c("5 sec.", "minute", "7 minutes", "hour", "day", "week", "month", "year")
) +
scale_y_continuous("Density\n") +
theme(axis.text.x = element_text(angle = 45, hjust = 1))
dev.off()

########################## All #################################################
svg("exploration/plots/inter-activity_time.movielens_actions.svg", height=5, width=7)
plot_clusters(
    actions[type=="all",]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

svg("exploration/plots/threshold_roc.movielens_actions.svg", height=5, width=7)
plot_roc(
    actions[type=="all",]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

svg("exploration/plots/true_and_false_positives.movielens_actions.svg", height=5, width=7)
plot_true_and_false_positives(
    actions[type=="all",]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

########################## Searches ############################################
svg("exploration/plots/inter-activity_time.movielens_searches.svg",
    height=5, width=7)
plot_clusters(
    actions[type=="search",]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

svg("exploration/plots/threshold_roc.movielens_searches.svg", height=5, width=7)
plot_roc(
    actions[type=="search",]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()

svg("exploration/plots/true_and_false_positives.movielens_searches.svg", height=5, width=7)
plot_true_and_false_positives(
    actions[type=="search",]$intertime,
    clusters=c("short_within", "long_within", "between")
)
dev.off()


############################### Old stuff ######################################
svg("exploration/plots/movielens_ratings.svg", height=5, width=7)
plot_clusters(ratings, clusters=3)
dev.off()

svg("exploration/plots/movielens_actions.two_clusters.svg", height=5, width=7)
plot_clusters(actions, clusters=2)
dev.off()

svg("exploration/plots/movielens_views.two_clusters.svg", height=5, width=7)
plot_clusters(views, clusters=2)
dev.off()

svg("exploration/plots/movielens_searches.two_clusters.svg", height=5, width=7)
plot_clusters(searches, clusters=2)
dev.off()

svg("exploration/plots/movielens_ratings.two_clusters.svg", height=5, width=7)
plot_clusters(ratings, clusters=2)
dev.off()
