-- ==========================
-- Basic GROUP BY
-- ==========================
SELECT
  author_id,
  COUNT(*)
FROM
  books
GROUP BY
  author_id;

-- ==========================
-- GROUP BY using two tables
-- ==========================
SELECT
  authors.name,
  COUNT(*)
FROM
  books
  JOIN authors ON authors.id = books.author_id
GROUP BY
  authors.name;

-- ==========================
-- HAVING (Example)
-- ==========================
SELECT
  photo_id,
  COUNT(*)
FROM
  comments
WHERE
  photo_id < 3
GROUP BY
  photo_id
HAVING
  COUNT(*) > 2;

SELECT
  user_id,
  COUNT(*)
FROM
  comments
WHERE
  photo_id < 50
GROUP BY
  user_id
HAVING
  COUNT(*) > 20;

-- ==========================
-- HAVING (Exercise)
-- ==========================
SELECT
  manufacturer,
  SUM(price * units_sold)
FROM
  phones
GROUP BY
  manufacturer
HAVING
  SUM(price * units_sold) > 2000000;