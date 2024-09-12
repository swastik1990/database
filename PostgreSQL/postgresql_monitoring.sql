-- list top 10 database with size
SELECT
  datname AS database,
  pg_size_pretty(pg_database_size(datname)) AS db_size
FROM pg_database
ORDER BY pg_database_size(datname) desc
LIMIT 10;

-- list top 10 tables with size
SELECT
    nspname AS table_schema,
    relname AS table_name,
    pg_size_pretty(pg_total_relation_size(C.oid)) AS total_size,
    pg_size_pretty(pg_relation_size(C.oid)) as table_size,
    pg_size_pretty(pg_total_relation_size(C.oid) - pg_relation_size(C.oid)) as index_size
FROM pg_class C
LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
WHERE nspname NOT IN ('pg_catalog', 'information_schema')
AND C.relkind <> 'i'
AND nspname !~ '^pg_toast'
ORDER BY pg_total_relation_size(C.oid) DESC
LIMIT 10;

-- view index vs sequential scan percentage
SELECT
	(sum(seq_scan)/sum(seq_scan+idx_scan) * 100)::numeric(10,2) AS seq_scan_percentage,
	(sum(idx_scan)/sum(seq_scan+idx_scan) * 100)::numeric(10,2) AS idx_scan_percentage
FROM pg_stat_user_tables;

-- number of database connections
SELECT state,
       backend_type,
       COUNT(*) as no_of_connections
FROM pg_stat_activity
WHERE state IS NOT NULL
GROUP BY state, backend_type
ORDER BY no_of_connections DESC;

-- percentage of max connections in use
SELECT 
	sum(numbackends)::float/(SELECT setting::float FROM pg_settings WHERE name = 'max_connections') AS max_conn_percent
FROM pg_stat_database;

-- cache hit ratio
SELECT sum(heap_blks_read) AS heap_read,
       sum(heap_blks_hit) AS heap_hit,
       sum(heap_blks_hit) / (sum(heap_blks_hit) + sum(heap_blks_read)) AS ratio
FROM pg_statio_user_tables;

-- index cache hit rate
SELECT sum(idx_blks_read) AS idx_read,
       sum(idx_blks_hit) AS idx_hit,
       (sum(idx_blks_hit) - sum(idx_blks_read)) / sum(idx_blks_hit) AS ratio
FROM pg_statio_user_indexes;

-- top 10 table index usage rate
SELECT relname,   
       100 * idx_scan / (seq_scan + idx_scan) percent_of_times_index_used,   
       n_live_tup rows_in_table 
FROM pg_stat_user_tables 
WHERE seq_scan + idx_scan > 0 
ORDER BY percent_of_times_index_used desc
LIMIT 10;

-- transaction committed percentage
SELECT 
	(sum(xact_commit)/sum(xact_commit+xact_rollback) * 100)::numeric(10,2) AS committed_percentage 
FROM pg_stat_database;

-- transaction rollback percentage
SELECT 
	(sum(xact_rollback)/sum(xact_commit+xact_rollback) * 100)::numeric(10,2) AS rollback_percentage 
FROM pg_stat_database;

-- total number of transactions executed (commits + rollbacks)
SELECT 
	sum(xact_commit+xact_rollback) AS total_transaction 
FROM pg_stat_database;
