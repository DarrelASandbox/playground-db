-- ====================================================
-- Performance Analysis of User Comments Query
-- This query block performs an execution plan analysis of a join operation 
-- between 'users' and 'comments' tables to retrieve the 'username' and 'contents'
-- for a specific user identified by the username 'Alyson14'.
-- ====================================================
EXPLAIN
ANALYZE
SELECT
  username,
  contents
FROM
  users
  JOIN comments ON comments.user_id = users.id
WHERE
  username = 'Alyson14';

-- ====================================================
-- Statistics Retrieval for 'users' Table
-- This query block fetches the statistics for the 'users' table from the 
-- 'pg_stats' system catalog, which provides data distribution information
-- and can be used to optimize query performance.
-- ====================================================
SELECT
  *
FROM
  pg_stats
WHERE
  tablename = 'users';

-- ====================================================
-- Execution Plan Analysis for 'likes' Table
-- This query block performs an execution plan analysis for the 'likes' table.
-- It focuses on retrieving records with a 'created_at' date prior to 2023-01-01.
-- This analysis helps in understanding the query performance for historical data.
-- ====================================================
EXPLAIN
SELECT
  *
FROM
  likes
WHERE
  created_at < '2023-01-01';

-- ====================================================
-- Index Creation on 'likes' Table
-- This command creates an index on the 'created_at' column of the 'likes' table.
-- Indexing this column is expected to improve query performance for operations
-- involving date-based filtering.
-- ====================================================
CREATE INDEX ON likes (created_at);

-- ====================================================
-- Count Analysis Post-2013 for 'likes' Table
-- This query calculates the total number of 'likes' recorded after 2013-01-01.
-- It is useful for analyzing the growth or trends in user engagement over time.
-- ====================================================
EXPLAIN
SELECT
  COUNT(*)
FROM
  likes
WHERE
  created_at > '2013-01-01';