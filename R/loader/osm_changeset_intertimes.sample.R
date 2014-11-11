source("env.R")
source("util.R")

load_osm_changeset_intertimes.sample = tsv_loader(
    paste(DATA_DIR, "osm_changeset_intertime.sample.tsv", sep="/"),
    "OSM_CHANGESET_INTERTIMES.SAMPLE",
    function(changesets){
        fast_changesets.by_user = changesets[
            intertime <= 5,
            list(
                count = length(intertime)
            ),
            user_id
        ]
        #hist(fast_changesets.by_user$count)
        problematic_ids = fast_changesets.by_user[count > 10,]$user_id
        #changesets[!user_id %in% problematic_ids]
        changesets[intertime > 5]
    }
)
