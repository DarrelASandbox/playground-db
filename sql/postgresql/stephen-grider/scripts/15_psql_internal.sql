-- ==========================
-- Display the current data directory path
-- This query returns the file path of the PostgreSQL data directory,
-- which is useful for database file management and diagnostics.
-- ==========================
SHOW data_directory;

-- ==========================
-- Retrieve database identifiers and names
-- This query lists all databases in the current PostgreSQL instance,
-- returning their OID (Object Identifier) and name.
-- Useful for identifying databases for further queries or maintenance.
-- ==========================
SELECT
  oid,
  datname
FROM
  pg_database;

-- ==========================
-- List all database objects
-- This query provides a comprehensive list of all objects (tables, indexes, etc.)
-- in the current database, useful for schema exploration or integrity checks.
-- ==========================
SELECT
  *
FROM
  pg_class;

-- ==========================
-- CREATE & DROP an index
-- ==========================
CREATE INDEX ON users (username);

DROP INDEX users_username_idx;

-- ==========================
-- Benchmarking queries
-- ==========================
EXPLAIN
ANALYZE
SELECT
  *
FROM
  users
WHERE
  username = 'Emil30';

-- ==========================
-- 872kb & 184kb respectively
-- ==========================
SELECT
  pg_size_pretty(pg_relation_size('users'));

SELECT
  pg_size_pretty(pg_relation_size('users_username_idx'));

-- ==========================
-- Retrieve Index Names and Types in PostgreSQL
-- ==========================
SELECT
  relname,
  relkind
FROM
  pg_class
WHERE
  relkind = 'i';