-- ==========================
-- Weekly Likes Summary Query
-- This query aggregates the number of likes for posts and comments on a weekly basis.
-- It uses date_trunc to normalize the timestamps to the start of the week, ensuring
-- that all likes are grouped correctly. The COALESCE function is used to handle cases
-- where either posts or comments might not have a created_at timestamp.
-- Results are grouped by week and ordered chronologically.
-- ==========================
SELECT
  date_trunc(
    'week',
    COALESCE(posts.created_at, comments.created_at)
  ) AS week,
  COUNT(posts.id) AS num_likes_for_posts,
  COUNT(comments.id) AS num_likes_for_comments
FROM
  likes
  LEFT JOIN posts ON posts.id = likes.post_id
  LEFT JOIN comments ON comments.id = likes.comment_id
GROUP BY
  week
ORDER BY
  week;

-- ==========================
-- Weekly Likes Materialized View Creation
-- This materialized view pre-calculates the weekly likes summary for posts and comments.
-- It stores the results of the aggregation query, which can then be queried directly
-- without the need to compute the aggregation on-the-fly every time. This is beneficial
-- for performance when dealing with a large number of likes. The materialized view is
-- created with the current data, and it can be refreshed periodically to update the stats.
-- ==========================
CREATE MATERIALIZED VIEW
  weekly_likes AS (
    SELECT
      date_trunc(
        'week',
        COALESCE(posts.created_at, comments.created_at)
      ) AS week,
      COUNT(posts.id) AS num_likes_for_posts,
      COUNT(comments.id) AS num_likes_for_comments
    FROM
      likes
      LEFT JOIN posts ON posts.id = likes.post_id
      LEFT JOIN comments ON comments.id = likes.comment_id
    GROUP BY
      week
    ORDER BY
      week
  )
WITH
  DATA;

SELECT
  *
FROM
  weekly_likes;

-- ==========================
-- Materialized View Refresh Command
-- This command refreshes the 'weekly_likes' materialized view to ensure it contains
-- up-to-date information. It should be run periodically, depending on the application's
-- needs and the frequency of data changes.
-- ==========================
REFRESH MATERIALIZED VIEW weekly_likes;