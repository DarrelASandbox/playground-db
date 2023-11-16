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

-- ============================================
-- Benchmarking User Query Performance
-- This section analyzes the performance of a query to retrieve user data based on username.
-- ============================================
EXPLAIN
ANALYZE
SELECT
  *
FROM
  users
WHERE
  username = 'Emil30';

-- =======================================================
-- Checking Database and Index Sizes for Optimization
-- These queries return the size of the 'users' table and its username index, aiding in assessing storage efficiency.
-- 872kb & 184kb respectively
-- =======================================================
SELECT
  pg_size_pretty(pg_relation_size('users'));

SELECT
  pg_size_pretty(pg_relation_size('users_username_idx'));

-- ===============================================
-- Listing Indexes in the Database
-- Retrieves a list of all index names and types in the PostgreSQL database.
-- ===============================================
SELECT
  relname,
  relkind
FROM
  pg_class
WHERE
  relkind = 'i';

-- =====================================================
-- Inspecting Index Pages for Detailed Analysis
-- Enables the inspection of individual pages of a specified index.
-- =====================================================
CREATE EXTENSION pageinspect;

SELECT
  *
FROM
  bt_metap ('users_username_idx');

-- ============================================================
-- Examining Specific Index Entries for In-Depth Insights
-- This query displays the contents of a specific page in the index, aiding in understanding its structure.
-- ============================================================
SELECT
  *
FROM
  bt_page_items ('users_username_idx', 1);

-- ====================================================
-- Locating a User Record by Username
-- Retrieves the complete record for a user with a specific username, including the tuple identifier (ctid).
-- 1d 41 61 6c 69 79 61 68 2e 48 69 6e 74 7a 00 00
-- ====================================================
SELECT
  ctid,
  *
FROM
  users
WHERE
  username = 'Aaliyah.Hintz';

-- ====================================================
-- oid: 82264
-- relfilenode: 82264
-- ====================================================
SELECT
  *
FROM
  pg_class
WHERE
  relname = 'users_username_idx';