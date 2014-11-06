CREATE TEMPORARY TABLE staging.intertime_revision_sample
SELECT
        rev_id,
        rev_user,
        rev_timestamp
FROM enwiki.revision
WHERE rev_user != 0
ORDER BY RAND()
LIMIT 1000000;
CREATE UNIQUE INDEX rev_idx ON halfak.session_revision_sample (rev_id);

SELECT
        rev_user,
        (UNIX_TIMESTAMP(irs.rev_timestamp) -
         UNIX_TIMESTAMP(max(prev.rev_timestamp)) AS intertime,
        "edit" AS type
FROM staging.intertime_revision_sample irs
INNER JOIN enwiki.revision prev USING (rev_user, rev_timestamp)
GROUP BY irs.rev_id;
