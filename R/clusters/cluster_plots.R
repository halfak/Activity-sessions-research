source("loader/aol_search_intertimes.sample.R")
source("loader/cyclopath_event_intertimes.R")
source("loader/enwiki_edit_intertimes.sample.R")
source("loader/lol_game_intertimes.sample.R")
source("loader/movielens_event_intertimes.sample.R")
source("loader/osm_changeset_intertimes.sample.R")
source("loader/stack_overflow_event_intertimes.sample.R")
source("loader/wikimedia_event_intertimes.sample.R")

source("clustering.R")

datasets = list(
    "aol search" =
        load_aol_search_intertimes.sample(reload=T)[type=="search"],
    "cyclopath select" =
        load_cyclopath_event_intertimes(reload=T)[type=="select"],
    "cyclopath route get" =
        load_cyclopath_event_intertimes()[type=="route get"],
    "lol game" =
        load_lol_game_intertimes.sample(reload=T)[type=="game"],
    "movielens search (combined)" =
        load_movielens_event_intertimes.sample(reload=T)[
                type=="search (combined)"],
    "movielens rating" =
        load_movielens_event_intertimes.sample()[type=="rating"],
    "movielens last rating" =
        load_movielens_event_intertimes.sample()[type=="last rating"],
    "osm changeset" =
        load_osm_changeset_intertimes.sample(reload=T)[type=="change set"],
    "stack overflow question" =
        load_stack_overflow_event_intertimes.sample(reload=T)[type=="question"],
    "stack overflow answer" =
        load_stack_overflow_event_intertimes.sample()[type=="answer"],
    "wikipedia edit" =
        load_enwiki_edit_intertimes.sample(reload=T)[type=="edit"],
    "wikimedia app view" =
        load_wikimedia_event_intertimes.sample(reload=T)[type=="app view"],
    "wikimedia desktop view" =
        load_wikimedia_event_intertimes.sample()[type=="desktop view"],
    "wikimedia mobile view" =
        load_wikimedia_event_intertimes.sample()[type=="mobile view"]
)

cluster_sets = list(
    "w/b" = list(
        clusters=c("within", "between"),
        split=c("within", "between")
    ),
    "w/b/e" = list(
        clusters=c("within", "between", "extended_break"),
        split=c("within", "between")
    ),
    "sw/lw/b" = list(
        clusters=c("short_within", "long_within", "between"),
        split=c("long_within", "between")
    ),
    "sw/lw/b/e" = list(
        clusters=c("short_within", "long_within", "between", "extended_break"),
        split=c("long_within", "between")
    ),
    "b/e" = list(
        clusters=c("between", "extended_break"),
        split=NA
    )
)

check_fitness = function(datasets, cluster_sets){
    
    fits = data.table()
    
    for(dataset_name in names(datasets)){
        intertimes = datasets[[dataset_name]]$intertime
        cat("Processing", dataset_name, " ")
        
        for(clusters_name in names(cluster_sets)){
            cat(".")
            clusters = cluster_sets[[clusters_name]]$cluster
            split = cluster_sets[[clusters_name]]$split
            fit = fit_intertimes(intertimes, clusters)
            if(!is.na(split)){
                threshold = extract_cutoff(fit, left=split[1], right=split[2])
            }else{
                threshold = NA
            }
            fits = rbind(fits,
                data.table(
                    dataset = dataset_name,
                    clusters = clusters_name,
                    threshold = threshold,
                    var_reduction = tryCatch(
                        var_reduction(intertimes, clusters, fit),
                        error=function(e){NA}
                    ),
                    davies_boulin = tryCatch(
                        davies_boulin(intertimes, clusters, fit),
                        error=function(e){NA}
                    ),
                    average_entropy = tryCatch(
                        average_entropy(intertimes, clusters, fit),
                        error=function(e){NA}
                    )
                )
            )
        }
        
        cat("DONE\n")
    }
    fits
}

fitness = check_fitness(datasets, cluster_sets)
write.table(fitness, "fitness.20141107.tsv", row.names=F, quote=F, sep="\t")
