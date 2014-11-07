dbstore = -u research -h analytics-store.eqiad.wmnet

datasets/aol_search_intertime.tsv:
		sessions/intertimes.py \
		datasets/originals/aol_search.tsv.bz2
	bzcat datasets/originals/aol_search.tsv.bz2 | tail -n+2 | \
	./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" > \
	datasets/aol_search_intertime.tsv

datasets/aol_search_intertime.sample.tsv: datasets/aol_search_intertime.tsv
	(head -n1 datasets/aol_search_intertime.tsv; \
	shuf -n 100000 datasets/aol_search_intertime.tsv | \
	grep -v $(head -n1 datasets/aol_search_intertime.tsv)) > \
	datasets/aol_search_intertime.sample.tsv

aol_samples: datasets/aol_search_intertime.sample.tsv

##################### MovieLens ################################################
# Types
# - search
# - advanced search
# - rating
# - last rating

datasets/movielens_event_intertime.sample.tsv: \
		sessions/intertimes.py \
		datasets/originals/movielens_event.tsv.bz2
	(echo "user_id\tintertime\ttype"; \
	 bzcat datasets/originals/movielens_event.tsv.bz2 | tail -n+2 | \
	 grep "rating" | ./intertimes | \
	 tail -n+2 | sed -r "s/(.*)/\1\trating/" | \
	 shuf -n 100000; \
	 bzcat datasets/originals/movielens_event.tsv.bz2 | tail -n+2 | \
	 grep "last rating" | ./intertimes | \
	 tail -n+2 | sed -r "s/(.*)/\1\tlast rating/" | \
	 shuf -n 100000; \
	 bzcat datasets/originals/movielens_event.tsv.bz2 | tail -n+2 | \
	 grep "search" | grep -v "advanced" | ./intertimes | \
	 tail -n+2 | sed -r "s/(.*)/\1\tsearch/" | \
	 shuf -n 100000; \
	 bzcat datasets/originals/movielens_event.tsv.bz2 | tail -n+2 | \
	 grep "advanced search" | ./intertimes | \
	 tail -n+2 | sed -r "s/(.*)/\1\tadvanced search/" | \
	 shuf -n 100000; \
	 bzcat datasets/originals/movielens_event.tsv.bz2 | tail -n+2 | \
	 grep "search" | ./intertimes | \
	 tail -n+2 | sed -r "s/(.*)/\1\tsearch (combined)/" | \
	 shuf -n 100000) > \
	datasets/movielens_event_intertime.sample.tsv

######################### Wikipedia ############################################
#datasets/originals/enwiki_edit_action.tsv: sql/edit_action.sql
#	cat sql/edit_action.sql | \
#	mysql $(dbstore) enwiki > \
#	datasets/originals/enwiki_edit_action.tsv

datasets/enwiki_edit_intertime.sample.tsv: \
	datasets/originals/enwiki_edit_intertime.1m_sample.tsv.bz2
	(echo "user_id\tintertime\ttype"; \
	 bzcat datasets/originals/enwiki_edit_intertime.1m_sample.tsv.bz2 | \
	 tail -n+2 | shuf -n 100000) > \
	datasets/enwiki_edit_intertime.sample.tsv

#datasets/enwiki_direct_sample_intertime.tsv: \
#		sql/enwiki_direct_sample_intertime.sql
#	cat sql/enwiki_direct_sample_intertime.sql | \
#	mysql $(dbstore) enwiki > \
#	datasets/enwiki_direct_sample_intertime.tsv

datasets/wikimedia_event_intertime.sample.tsv: \
		sessions/intertimes.py \
		datasets/originals/wikimedia/app_view.tsv.bz2 \
		datasets/originals/wikimedia/mobile_view.tsv.bz2 \
		datasets/originals/wikimedia/ms_desktop_view.tsv.bz2
	(echo "user_id\tintertime\ttype"; \
	 bzcat datasets/originals/wikimedia/app_view.tsv.bz2 | tail -n+2 | \
	 ./intertimes --timestamp-format="%Y-%m-%dT%H:%M:%S" | \
	 tail -n+2 | sed -r "s/(.*)/\1\tapp view/" | \
	 shuf -n 100000; \
	 bzcat datasets/originals/wikimedia/mobile_view.tsv.bz2 | tail -n+2 | \
	 ./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
	 tail -n+2 | sed -r "s/(.*)/\1\tmobile view/" | \
	 shuf -n 100000; \
	 bzcat datasets/originals/wikimedia/ms_desktop_view.tsv.bz2 | tail -n+2 | \
	 ./intertimes --timestamp-format="%Y%m%d%H%M%S" | \
	 tail -n+2 | sed -r "s/(.*)/\1\tdesktop view/" | \
	 shuf -n 100000) > \
	datasets/wikimedia_event_intertime.sample.tsv

####################### League of Legends ######################################
datasets/lol_game_intertime.sample.tsv: \
		datasets/originals/lol_game_intertime.tsv.bz2 \
		sessions/intertimes.py
	(echo "user_id\tintertime\ttype"; \
	 bzcat datasets/originals/lol_game_intertime.tsv.bz2 | \
	 tail -n+2  | shuf -n 100000; ) > \
	datasets/lol_game_intertime.sample.tsv
	
	
	
####################### Stack Overflow #########################################
#
# 1  Question
# 2  Answer
# 3  Tag Wiki
#
datasets/stack_overflow_event_intertime.sample.tsv: \
		datasets/originals/stack_overflow_post.tsv.bz2
	(echo "user_id\tintertime\ttype"; \
	 bzcat datasets/originals/stack_overflow_post.tsv.bz2 | tail -n+2 | \
	 grep -E "1$" | \
	 ./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
	 sed -r "s/(.+)/\1\tquestion/" | tail -n+2 | shuf -n 100000; \
	 bzcat datasets/originals/stack_overflow_post.tsv.bz2 | \
	 tail -n+2 | grep -E "2$" | \
	 ./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
	 sed -r "s/(.+)/\1\tanswer/" | tail -n+2 | shuf -n 100000) > \
	datasets/stack_overflow_event_intertime.sample.tsv


########################## Open Street Map #####################################
#datasets/osm_change_intertime.tsv.bz2: \
#		datasets/originals/osm_change.sorted.tsv.bz2
#	bzcat datasets/originals/osm_change.sorted.tsv.bz2 | tail -n+2 | \
#	./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | bzip2 -c > \
#	datasets/osm_edit_intertime.tsv.bz2
	
#datasets/osm_change_intertime.sample.tsv: \
#		datasets/osm_change_intertime.tsv.bz2
#	(echo "user_id\tintertime\ttype"; \
#	 bzcat datasets/osm_change_intertime.tsv.bz2 |  \
#	 tail -n+2 | sed -r "s/(.+)/\1\tchange/"  | shuf -n 100000 ) > \
#	datasets/osm_change_intertime.sample.tsv

#datasets/originals/osm_change.sorted.collapsed.tsv.bz2: \
#		datasets/originals/osm_change.sorted.tsv.bz2
#	bzcat datasets/originals/osm_change.sorted.tsv.bz2 | \
#	tail -n+2 | \
#	python sessions/last_osm_change --timestamp-format="%Y-%m-%d %H:%M:%S" | \
#	bzip2 -c > \
#	datasets/originals/osm_change.sorted.collapsed.tsv.bz2

datasets/osm_changeset_intertime.tsv.bz2: \
		datasets/originals/osm_changeset.tsv.bz2
	bzcat datasets/originals/osm_changeset.tsv.bz2 | tail -n+2 | \
	./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | bzip2 -c > \
	datasets/osm_changeset_intertime.tsv.bz2

# Large sample to account for crap values
datasets/osm_changeset_intertime.sample.tsv: \
	datasets/osm_changeset_intertime.tsv.bz2
	(echo "user_id\tintertime\ttype"; \
	 bzcat datasets/osm_changeset_intertime.tsv.bz2 |  \
	 tail -n+2 | sed -r "s/(.+)/\1\tchange_set/"  | shuf -n 1000000 ) > \
	 datasets/osm_changeset_intertime.sample.tsv

############################ Cyclopath #########################################

#Not sampled
datasets/cyclopath_action_intertime.tsv: \
		datasets/originals/cyclopath_route_get.tsv.bz2 \
		datasets/originals/cyclopath_select.tsv.bz2
	(echo "user_id\tintertime\ttype"; \
	bzcat datasets/originals/cyclopath_select.tsv.bz2 | \
	./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
	tail -n+2 | sed -r "s/(.+)/\1\tselect/"; \
	bzcat datasets/originals/cyclopath_route_get.tsv.bz2 | \
	./intertimes --timestamp-format="%Y-%m-%d %H:%M:%S" | \
	tail -n+2 | sed -r "s/(.+)/\1\troute_get/") > \
	datasets/cyclopath_action_intertime.tsv
