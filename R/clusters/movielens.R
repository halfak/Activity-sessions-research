source("loader/movielens_action_intertimes.sample.R")

actions = load_movielens_action_intertimes.sample(reload=T)
actions = data.table(read.table(
    "../datasets/movielens_action_intertime.sample.old.tsv",
    header=T, sep="\t",
    quote="", comment.char="",
    na.strings="NULL",
    fill=T, row.names=NULL
))
actions$user_id = actions$row.names
actions$type.first = actions$intertime
actions$intertime = actions$X.e.user_id
actions[type == "",]$type = actions[type == "",]$type.first

source('clustering.R')

svg("clusters/plots/movielens_repeated_actions.svg", height=12, width=5)
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


svg("clusters/plots/movielens_actions.svg", height=5, width=7)
plot_clusters(actions, clusters=3)
dev.off()

svg("clusters/plots/movielens_views.svg", height=5, width=7)
plot_clusters(views, clusters=3)
dev.off()

svg("clusters/plots/movielens_searches.svg", height=5, width=7)
plot_clusters(searches, clusters=3)
dev.off()

svg("clusters/plots/movielens_ratings.svg", height=5, width=7)
plot_clusters(ratings, clusters=3)
dev.off()



svg("clusters/plots/movielens_actions.two_clusters.svg", height=5, width=7)
plot_clusters(actions, clusters=2)
dev.off()

svg("clusters/plots/movielens_views.two_clusters.svg", height=5, width=7)
plot_clusters(views, clusters=2)
dev.off()

svg("clusters/plots/movielens_searches.two_clusters.svg", height=5, width=7)
plot_clusters(searches, clusters=2)
dev.off()

svg("clusters/plots/movielens_ratings.two_clusters.svg", height=5, width=7)
plot_clusters(ratings, clusters=2)
dev.off()
