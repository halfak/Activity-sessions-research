source("loader/lol_game_intertimes.sample.R")

games = load_lol_game_intertimes.sample(reload=T)

source('clustering.R')

svg("exploration/plots/inter-activity_time.lol_games.svg", height=5, width=7)
plot_clusters(games$intertime, c("within", "between"))
dev.off()

svg("exploration/plots/threshold_roc.lol_games.svg", height=5, width=7)
plot_roc(games$intertime, c("within", "between"))
dev.off()

svg("exploration/plots/true_and_false_positives.lol_games.svg",
    height=5, width=7)
plot_true_and_false_positives(games$intertime, c("within", "between"))
dev.off()

svg("exploration/plots/true_and_false_positive_difference.lol_games.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    games$intertime,
    clusters=c("within", "between")
)
dev.off()
