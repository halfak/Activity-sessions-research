datasets/aol_search_intertime.tsv: sessions/intertimes.py
	tail -n+2 datasets/aol_search_action.tsv | \
	./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" > \
	datasets/aol_search_intertime.tsv

datasets/aol_search_intertime.sample.tsv: datasets/aol_search_intertime.tsv
	(head -n1 datasets/aol_search_intertime.tsv; \
	shuf -n 500000 datasets/aol_search_intertime.tsv | \
	grep -v $(head -n1 datasets/aol_search_intertime.tsv)) > \
	datasets/aol_search_intertime.sample.tsv

aol_samples: datasets/aol_search_intertime.sample.tsv

##################### MovieLens ################################################
datasets/movielens_action_intertime.sample.tsv: \
		sessions/intertimes.py \
		datasets/movielens_action.tsv
	(\
		echo -e "user_id\tintertime\ttype"; \
		tail -n+2 datasets/movielens_action.tsv | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tall/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "browse movie by tag" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tbrowse movie by tag/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "default-page" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tdefault-page/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "info-seeking" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tinfo-seeking/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "invite" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tinvite/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "Most Often Rated" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tMost Often Rated/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "moviedetail" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tmoviedetail/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "Newest Edition" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tNewest Edition/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "profile" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tprofile/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "Rate-Random-Movies" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tRate-Random-Movies/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "rating" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\trating/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "search" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tsearch/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "Top Picks" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tTop Picks/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "Your Ratings" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tYour Ratings/" | \
		shuf -n 100000; \
		tail -n+2 datasets/movielens_action.tsv | \
		grep "Your Wish List" | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tYour Wish List/" | \
		shuf -n 100000; \
	) | \
	tail --bytes+4 > \
	datasets/movielens_action_intertime.sample.tsv
