source("env.R")
source("util.R")

load_lol_game_intertimes.sample = tsv_loader(
    paste(DATA_DIR, "lol_game_intertime.sample.tsv", sep="/"),
    "LOL_GAME_INTERTIMES.SAMPLE"
)
