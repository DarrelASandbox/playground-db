-- ==========================
-- Using subqueries
-- ==========================
SELECT
  username,
  tags.created_at
FROM
  users
  JOIN (
    SELECT
      user_id,
      created_at
    FROM
      caption_tags
    UNION ALL
    SELECT
      user_id,
      created_at
    FROM
      photo_tags
  ) AS tags ON tags.user_id = users.id
WHERE
  tags.created_at < '2010-01-07';

-- ==========================
-- Simple Form CTE
-- ==========================
WITH
  tags AS (
    SELECT
      user_id,
      created_at
    FROM
      caption_tags
    UNION ALL
    SELECT
      user_id,
      created_at
    FROM
      photo_tags
  )
SELECT
  username,
  tags.created_at
FROM
  users
  JOIN tags ON tags.user_id = users.id
WHERE
  tags.created_at < '2010-01-07';

-- ==========================
-- Recursive CTE
-- ==========================
WITH RECURSIVE
  countdown (val) AS (
    SELECT
      7 AS val -- Initial, Non-recursive query
    UNION
    SELECT -- Recursive query
      val -1
    FROM
      countdown
    WHERE
      val > 1
  )
SELECT
  *
FROM
  countdown;

-- ==========================
-- CTE for Instagram Database
-- ==========================
WITH RECURSIVE
  suggestions (leader_id, follower_id, depth) AS (
    SELECT
      leader_id,
      follower_id,
      1 AS depth
    FROM
      followers
    WHERE
      follower_id = 1000
    UNION
    SELECT
      followers.leader_id,
      followers.follower_id,
      depth + 1
    FROM
      followers
      JOIN suggestions ON suggestions.leader_id = followers.follower_id
    WHERE
      depth < 3
  )
SELECT DISTINCT
  users.id,
  users.username
FROM
  suggestions
  JOIN users ON users.id = suggestions.leader_id
WHERE
  depth > 1
LIMIT
  30;