-- ==========================
-- Merging Tables
-- This query merges data from 'photo_tags' and 'caption_tags' through a UNION ALL
-- and then joins the result with the 'users' table to count the number of tags per user.
-- It's useful for understanding user engagement across different tagging contexts.
-- ==========================
SELECT
  username,
  COUNT(*)
FROM
  users
  JOIN (
    SELECT
      user_id
    FROM
      photo_tags
    UNION ALL
    SELECT
      user_id
    FROM
      caption_tags
  ) AS tags ON tags.user_id = users.id
GROUP BY
  username
ORDER BY
  COUNT(*) DESC;

-- ==========================
-- Solution 1: Table Consolidation
-- This script creates a single 'tags' table to consolidate 'photo_tags' and 'caption_tags'.
-- It aims to streamline the tagging system by merging similar data structures.
-- The process involves creating the new table, migrating existing data, and then
-- potentially removing the original tables to avoid redundancy.
-- ==========================
-- Create single tags table
CREATE TABLE
  tags (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    x INTEGER,
    y INTEGER
  );

-- Copy all the rows from photo_tags
INSERT INTO
  tags (created_at, updated_at, user_id, post_id, x, y)
SELECT
  created_at,
  updated_at,
  user_id,
  post_id,
  x,
  y
FROM
  photo_tags;

-- Copy all the rows from caption_tags
INSERT INTO
  tags (created_at, updated_at, user_id, post_id)
SELECT
  created_at,
  created_at,
  user_id,
  post_id
FROM
  caption_tags;

-- ==========================
-- Unified Tags View Creation
-- This view consolidates records from both 'photo_tags' and 'caption_tags' tables.
-- It creates a unified view 'tags' that includes a type distinction for each tag.
-- This allows for simplified queries when retrieving tag data regardless of type,
-- improving readability and maintainability of SQL operations involving tag data.
-- ==========================
CREATE VIEW
  tags AS (
    SELECT
      id,
      created_at,
      user_id,
      post_id,
      'photo_tag' AS
    type
    FROM
      photo_tags
    UNION ALL
    SELECT
      id,
      created_at,
      user_id,
      post_id,
      'caption_tag' AS
    type
    FROM
      caption_tags
  );

SELECT
  *
FROM
  tags;

-- ==========================
-- Recent Posts View Creation
-- This view is designed to provide quick access to the most recent posts.
-- It selects all columns from the 'posts' table, orders them by the 'created_at' field 
-- in descending order, and limits the results to the 10 latest posts. This view is 
-- particularly useful for displaying the latest content on a dashboard or a feed.
-- ==========================
CREATE VIEW
  recent_posts AS (
    SELECT
      *
    FROM
      posts
    ORDER BY
      created_at DESC
    LIMIT
      10
  );

SELECT
  *
FROM
  recent_posts;

-- ==========================
-- Updating existing view
-- ==========================
CREATE OR REPLACE VIEW
  recent_posts AS (
    SELECT
      *
    FROM
      posts
    ORDER BY
      created_at DESC
    LIMIT
      15
  );

SELECT
  *
FROM
  recent_posts;

DROP VIEW recent_posts;