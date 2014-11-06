dbstore = -u research -h analytics-store.eqiad.wmnet

datasets/aol_search_intertime.tsv:
		sessions/intertimes.py \
		datasets/originals/aol_search_action.tsv
	tail -n+2 datasets/originals/aol_search_action.tsv | \
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
		datasets/originals/movielens_action.tsv
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
	tail --bytes=+4 > \
	datasets/movielens_action_intertime.sample.tsv

######################### Wikipedia ############################################
datasets/originals/enwiki_edit_action.tsv: sql/edit_action.sql
	cat sql/edit_action.sql | \
	mysql $(dbstore) enwiki > \
	datasets/originals/enwiki_edit_action.tsv

datasets/enwiki_edit_intertime.sample.tsv: \
	datasets/originals/enwiki_edit_action.tsv
	( \
		echo -e "user_id\tintertime\ttype"; \
		tail -n+2 datasets/originals/enwiki_edit_action.tsv | \
		./intertimes --timestamp-format="%Y%m%d%H%M%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\trevision/" | shuf -n 500000; \
	) | tail --bytes=+3 > \
	datasets/enwiki_edit_intertime.sample.tsv

datasets/enwiki_direct_sample_intertime.tsv: \
		sql/enwiki_direct_sample_intertime.sql
	cat sql/enwiki_direct_sample_intertime.sql | \
	mysql $(dbstore) enwiki > \
	datasets/enwiki_direct_sample_intertime.tsv

datasets/wikipedia_action_intertime.sample.tsv: \
		sessions/intertimes.py \
		datasets/originals/wikipedia/app_view.tsv.gz \
		datasets/originals/wikipedia/desktop_view.tsv.gz \
		datasets/originals/wikipedia/edit.tsv.gz \
		datasets/originals/wikipedia/mobile_view.tsv.gz \
		datasets/originals/wikipedia/search.tsv.gz\
		datasets/originals/wikipedia/search_suggestion.tsv.gz
	(\
		echo -e "user_id\tintertime\ttype"; \
		zcat datasets/originals/wikipedia/app_view.tsv.gz | \
		tail -n+2 | sort | \
		./intertimes --timestamp-format="%Y-%m-%dT%H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tapp view/" | \
		shuf -n 100000; \
		zcat datasets/originals/wikipedia/desktop_view.tsv.gz | \
		tail -n+2 | sort | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tdesktop view/" | \
		shuf -n 100000; \
		zcat datasets/originals/wikipedia/edit.tsv.gz | \
		tail -n+2 | sort | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tedit/" | \
		shuf -n 100000; \
		zcat datasets/originals/wikipedia/mobile_view.tsv.gz | \
		tail -n+2 | sort | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tmobile view/" | \
		shuf -n 100000; \
		zcat datasets/originals/wikipedia/search.tsv.gz | \
		tail -n+2 | sort | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tsearch/" | \
		shuf -n 100000;\
		zcat datasets/originals/wikipedia/search_suggestion.tsv.gz | \
		tail -n+2 | sort | \
		./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
		tail -n+2 | sed -r "s/(.*)/\1\tsearch suggestion/" | \
		shuf -n 100000; \
	) | \
	tail --bytes=+4 > \
	datasets/wikipedia_action_intertime.sample.tsv

####################### League of Legends ######################################
datasets/lol_game_intertime.sample.tsv: \
		datasets/originals/lol_game_intertime.tsv.bz2 \
		sessions/intertimes.py
	(echo -e "user_id\tintertime\ttype"; \
	 bzcat datasets/originals/lol_game_intertime.tsv.bz2 | \
	 tail -n+2  | shuf -n 500000; ) | \
	tail --bytes=+4 > \
	datasets/lol_game_intertime.sample.tsv
	
	
	
####################### Stack Overflow #########################################
#
# 1  Question
# 2  Answer
# 3  Tag Wiki
#
datasets/stack_overflow_post_intertime.sample.tsv: \
		datasets/originals/stack_overflow_post.tsv.bz2
	(echo -e "user_id\tintertime\ttype"; \
	 bzcat datasets/originals/stack_overflow_post.tsv.bz2 | \
	 tail -n+2 | \
	 ./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
	 sed -r "s/(.+)/\1\tall/" | tail -n+2 | shuf -n 100000; \
	 bzcat datasets/originals/stack_overflow_post.tsv.bz2 | \
	 tail -n+2 | grep -E "1$" | \
	 ./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
	 sed -r "s/(.+)/\1\tquestion/" | tail -n+2 | shuf -n 100000; \
	 bzcat datasets/originals/stack_overflow_post.tsv.bz2 | \
	 tail -n+2 | grep -E "2$" | \
	 ./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
	 sed -r "s/(.+)/\1\tanswer/" | tail -n+2 | shuf -n 100000; \
	 bzcat datasets/originals/stack_overflow_post.tsv.bz2 | \
	 tail -n+2 | grep -E "(1|2)$" | \
	 ./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
	 sed -r "s/(.+)/\1\tquestion\/answer/" | tail -n+2 | shuf -n 100000; \
	 bzcat datasets/originals/stack_overflow_post.tsv.bz2 | \
	 tail -n+2 | grep -E "3$" | \
	 ./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
	 sed -r "s/(.+)/\1\ttag wiki/" | tail -n+2 | shuf -n 100000;) | \
	tail --bytes=+4 > \
	datasets/stack_overflow_post_intertime.sample.tsv


########################## Open Street Map #####################################
datasets/osm_change_intertime.tsv.bz2: \
		datasets/originals/osm_change.sorted.tsv.bz2
	bzcat datasets/originals/osm_change.sorted.tsv.bz2 | tail -n+2 | \
	./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | bzip2 -c > \
	datasets/osm_edit_intertime.tsv.bz2
	
datasets/osm_change_intertime.sample.tsv: \
		datasets/osm_change_intertime.tsv.bz2
	(echo "user_id\tintertime\ttype"; \
	 bzcat datasets/osm_change_intertime.tsv.bz2 |  \
	 tail -n+2 | sed -r "s/(.+)/\1\tchange/"  | shuf -n 500000 ) > \
	datasets/osm_change_intertime.sample.tsv

#datasets/originals/osm_change.sorted.collapsed.tsv.bz2: \
#		datasets/originals/osm_change.sorted.tsv.bz2
#	bzcat datasets/originals/osm_change.sorted.tsv.bz2 | \
#	tail -n+2 | \
#	python sessions/last_osm_change --timestamp-format="%Y-%m-%d %H:%M:%S" | \
#	bzip2 -c > \
#	datasets/originals/osm_change.sorted.collapsed.tsv.bz2

datasets/osm_changeset_intertime.tsv.bz2: \
		datasets/originals/osm_changeset.sorted.tsv.bz2
	bzcat datasets/originals/osm_changeset.sorted.tsv.bz2 | tail -n+2 | \
	./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | bzip2 -c > \
	datasets/osm_changeset_intertime.tsv.bz2

datasets/osm_changeset_intertime.sample.tsv: \
	datasets/osm_changeset_intertime.tsv.bz2
	(echo "user_id\tintertime\ttype"; \
	 bzcat datasets/osm_changeset_intertime.tsv.bz2 |  \
	 tail -n+2 | sed -r "s/(.+)/\1\tchange_set/"  | shuf -n 500000 ) > \
	 datasets/osm_changeset_intertime.sample.tsv

############################ Cyclopath #########################################

#Not sampled
datasets/cyclopath_select_intertime.tsv: \
		datasets/originals/cyclopath_select.tsv.bz2
	bzcat datasets/originals/cyclopath_select.tsv.bz2 | \
	./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" > \
	datasets/cyclopath_select_intertime.tsv

# Not sampled
datasets/cyclopath_route_get_intertime.tsv: \
		datasets/originals/cyclopath_route_get.tsv.bz2
	bzcat datasets/originals/cyclopath_route_get.tsv.bz2 | \
	./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" > \
	datasets/cyclopath_route_get_intertime.tsv
