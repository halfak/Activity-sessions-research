source("loader/all_datasets.R")

all_datasets = load_all_datasets(reload=T)

source("clustering.R")

generate_fits = function(datasets, clusters, split){
    rbindlist(lapply(
        names(datasets),
        function(dataset_name){
            fit = fit_intertimes(
                    datasets[[dataset_name]]$data$intertime, clusters)
                    
            fits = data.table(
                dataset = dataset_name,
                threshold = round(2^extract_cutoff(fit, split[1], split[2]), 1)
            )
            for(name in names(fit)){
                fits[[paste(name, "mu", sep=".")]] =
                        round(fit[[name]]$mu, 1)
                fits[[paste(name, "sigma", sep=".")]] =
                        round(fit[[name]]$sigma, 1)
                fits[[paste(name, "lambda", sep=".")]] =
                        round(fit[[name]]$lambda, 2)
            }
            fits
        }
    ))
}

generate_fits(all_datasets[c('aol search', 'cyclopath route get',
               'wikimedia app view', 'wikimedia mobile view',
               'wikimedia desktop view')],
              clusters=c("within", "between"),
              split=c("within", "between"))
#                  dataset threshold within.mu within.sigma within.lambda
#1:             aol search    6928.8       6.7          2.9          0.70
#2:    cyclopath route get    5315.9       5.0          2.5          0.87
#3:     wikimedia app view    1767.6       5.2          2.3          0.74
#4:  wikimedia mobile view    2997.0       6.4          2.6          0.65
#5: wikimedia desktop view    2741.3       5.5          2.6          0.75
#   between.mu between.sigma between.lambda
#1:       16.8           2.2           0.30
#2:       18.6           3.1           0.13
#3:       15.7           2.5           0.26
#4:       15.8           2.5           0.35
#5:       15.7           2.5           0.25

generate_fits(
    all_datasets[c('osm changeset','wikipedia edit')],
    clusters=c("within", "between", "break"),
    split=c("within", "between")
)
#          dataset threshold within.mu within.sigma within.lambda between.mu
#1:  osm changeset    6031.0       8.6          2.1          0.68       15.5
#2: wikipedia edit    4797.1       6.8          2.5          0.83       15.4
#   between.sigma between.lambda break.mu break.sigma break.lambda
#1:           2.5           0.30     22.7         2.0         0.02
#2:           2.7           0.16     22.6         1.9         0.01


generate_fits(
    all_datasets[c('movielens rating',
                   'movielens search')],
    clusters=c("short_within", "within", "between"),
    split=c("within", "between")
)
#            dataset threshold short_within.mu short_within.sigma
#1: movielens rating    1995.8               3                1.3
#2: movielens search    3099.8               4                0.8
#   short_within.lambda within.mu within.sigma within.lambda between.mu
#1:                0.58       5.2          1.9          0.34       18.0
#2:                0.30       5.7          2.5          0.50       17.1
#   between.sigma between.lambda
#1:           3.0           0.07
#2:           3.1           0.20

generate_fits(
    all_datasets[c('lol game')],
    clusters=c("within", "between"),
    split=c("within", "between")
)
#    dataset threshold within.mu within.sigma within.lambda between.mu
#1: lol game     850.7       8.3          0.5          0.59       14.1
#   between.sigma between.lambda
#1:           2.8           0.41



generate_fits(
    all_datasets[c('stack overflow answer', 'stack overflow question')],
    clusters=c("within", "between", "break"),
    split=c("within", "between")
)
#                   dataset threshold within.mu within.sigma within.lambda
#1:   stack overflow answer    5486.6      10.2          1.7           0.3
#2: stack overflow question   20081.2      12.7          1.7           0.1
#   between.mu between.sigma between.lambda break.mu break.sigma break.lambda
#1:       16.6           2.9           0.63     23.0         1.5         0.06
#2:       18.5           2.1           0.63     22.4         1.7         0.26
