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