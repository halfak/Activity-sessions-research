source("loader/all_datasets.R")

all_datasets = load_all_datasets(reload=T)

source("clustering.R")

plot_clusters_datasets(
    all_datasets[c('aol search')],
    clusters=c("within", "between"),
    split=c("within", "between")
)
    

pdf("clusters/plots/bimodal_clusters.pdf", height=12, width=5)
g = plot_clusters_datasets(
    all_datasets[c('aol search', 'cyclopath route get',
                   'wikimedia app view', 'wikimedia mobile view',
                   'wikimedia desktop view')],
    clusters=c("within", "between"),
    split=c("within", "between")
)
g
dev.off()
png("clusters/plots/bimodal_clusters.png", height=1200, width=500, res=150)
g
dev.off()

pdf("clusters/plots/trimodal_clusters.pdf", height=8, width=5)
g = plot_clusters_datasets(
    all_datasets[c('osm changeset','wikipedia edit')],
    clusters=c("within", "between", "break"),
    split=c("within", "between")
)
g
dev.off()
png("clusters/plots/trimodal_clusters.png", height=800, width=500, res=150)
g
dev.off()


pdf("clusters/plots/operation_mixed_clusters.pdf", height=6, width=5)
source("clustering.R")
g = plot_clusters_datasets(
    all_datasets[c('movielens rating',
                   'movielens search')],
    clusters=c("short_within", "within", "between"),
    split=c("within", "between")
)
g
dev.off()
png("clusters/plots/operation_mixed_clusters.png", height=600, width=500, res=150)
g
dev.off()

pdf("clusters/plots/weird_lol_clusters.pdf", height=5, width=5)
g = plot_clusters_datasets(
    all_datasets[c('lol game')],
    clusters=c("within", "between"),
    split=c("within", "between")
)
g
dev.off()
png("clusters/plots/weird_lol_clusters.png", height=500, width=500, res=150)
g
dev.off()


pdf("clusters/plots/weird_so_clusters.pdf", height=6, width=5)
g = plot_clusters_datasets(
    all_datasets[c('stack overflow answer', 'stack overflow question')],
    clusters=c("within", "between", "break"),
    split=c("within", "between")
)
g
dev.off()
png("clusters/plots/weird_so_answer_clusters.png", height=600, width=500, res=150)
g
dev.off()
