-- ==========================
-- Create Schema and User Table
-- This block is responsible for creating a new schema named 'test' and a user table within that schema.
-- The user table contains two columns: 'id' (a primary key) and 'username'.
-- ==========================
CREATE SCHEMA test;

CREATE TABLE
  test.users (id SERIAL PRIMARY KEY, username VARCHAR);

-- ==========================
-- Insert into User Table
-- This block is intended to insert data into the 'users' table. 
-- ==========================
INSERT INTO
  test.users (username)
VALUES
  ('This is my bio', 'Alyson14'),
  ('This is about me', 'Gia67');

-- ==========================
-- Show Current Search Path
-- This block displays the current search path setting in the database, which determines which schemas
-- are checked when an unqualified table name is used.
-- ==========================
SHOW search_path;

-- ==========================
-- Change Search Path
-- This block changes the search path to prioritize the 'test' schema, followed by 'public'.
-- It affects how SQL statements will resolve unqualified object names.
-- ==========================
SET
  search_path TO test,
  public;

-- ==========================
-- Reset Search Path
-- This block resets the search path to the default, which usually starts with the user's schema
-- (represented as "$user") followed by 'public'.
-- This is important to ensure subsequent operations use the standard search path.
-- ==========================
SET
  search_path TO "$user",
  public;