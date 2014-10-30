datasets/aol_search_intertime.tsv: sessions/intertimes.py
	tail -n+2 datasets/aol_search_action.tsv | \
	./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" > \
	datasets/aol_search_intertime.tsv

datasets/aol_search_intertime.sample.tsv: datasets/aol_search_intertime.tsv
	(echo -e "user\tintertime"; \
	shuf -n 100000 datasets/aol_search_intertime.tsv | \
	grep -v "user\tintertime") > \
	datasets/aol_search_intertime.sample.tsv
