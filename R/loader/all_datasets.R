source("loader/aol_search_intertimes.sample.R")
source("loader/cyclopath_event_intertimes.R")
source("loader/enwiki_edit_intertimes.sample.R")
source("loader/lol_game_intertimes.sample.R")
source("loader/movielens_event_intertimes.sample.R")
source("loader/osm_changeset_intertimes.sample.R")
source("loader/stack_overflow_event_intertimes.sample.R")
source("loader/wikimedia_event_intertimes.sample.R")

load_all_datasets = data_loader(
    function(verbose=T, reload=F){
        list(
            "aol search" = list(
                site="aol",
                event="search",
                data=load_aol_search_intertimes.sample(reload=reload)[
                        type=="search"]
            ),
            "cyclopath select" = list(
                site="cyclopath",
                event="select",
                data=load_cyclopath_event_intertimes(reload=reload)[
                        type=="select"]
            ),
            "cyclopath route get" = list(
                site="cyclopath",
                event="route get",
                data=load_cyclopath_event_intertimes()[type=="route get"]
            ),
            "lol game" = list(
                site="lol",
                event="game",
                data=load_lol_game_intertimes.sample(reload=reload)[
                        type=="game"]
            ),
            "movielens search" = list(
                site="movielens",
                event="search",
                data=load_movielens_event_intertimes.sample(reload=reload)[
                        type=="search"]
            ),
            #"movielens rating" = list(
            #    site="movielens",
            #    event="rating",
            #    data=load_movielens_event_intertimes.sample()[
            #            type=="rating"]
            #),
            "movielens rating" = list(
                site="movielens",
                event="rating",
                data=load_movielens_event_intertimes.sample()[
                        type=="last rating"]
            ),
            "osm changeset" = list(
                site="osm",
                event="changeset",
                data=load_osm_changeset_intertimes.sample(reload=reload)[
                        type=="change set"]
            ),
            "stack overflow question" = list(
                site="stack overflow",
                event="question",
                data=load_stack_overflow_event_intertimes.sample(reload=reload)[
                        type=="question"]
            ),
            "stack overflow answer" = list(
                site="stack overflow",
                event="answer",
                data=load_stack_overflow_event_intertimes.sample()[
                        type=="answer"]
            ),
            "wikipedia edit" = list(
                site="wikipedia",
                event="edit",
                data=load_enwiki_edit_intertimes.sample(reload=reload)[
                        type=="edit"]
            ),
            "wikimedia app view" = list(
                site="wikimedia",
                event="app view",
                data=load_wikimedia_event_intertimes.sample(reload=reload)[
                        type=="app view"]
            ),
            "wikimedia desktop view" = list(
                site="wikimedia",
                event="desktop view",
                data=load_wikimedia_event_intertimes.sample()[
                        type=="desktop view"]
            ),
            "wikimedia mobile view" = list(
                site="wikimedia",
                event="mobile view",
                data=load_wikimedia_event_intertimes.sample()[
                        type=="mobile view"]
            )
        )
    },
    "ALL_DATASETS"
)
