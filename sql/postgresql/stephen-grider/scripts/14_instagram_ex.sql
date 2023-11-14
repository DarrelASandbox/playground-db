-- ==========================
-- Select 3 users with the highest
-- IDs from the users table
-- ==========================
SELECT
  *
FROM
  users
ORDER BY
  id DESC
LIMIT
  3;

-- ==========================
-- Show the username of user ID
-- 200 and the captions of all
-- posts they have created
-- ==========================
SELECT
  username,
  caption
FROM
  users u
  JOIN posts p ON u.id = p.user_id
WHERE
  u.id = 200;

-- ==========================
-- Show each username and the
-- number of 'likes' that they
-- have created
-- ==========================
SELECT
  username,
  COUNT(*) as likes_count
FROM
  users u
  JOIN likes l ON u.id = l.user_id
GROUP BY
  username;