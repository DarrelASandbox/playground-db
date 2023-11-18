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