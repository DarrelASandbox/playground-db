-- ==========================
-- SORTING
-- ==========================
SELECT
  *
FROM
  products
ORDER BY
  price ASC,
  weight DESC;

-- ==========================
--  PAGINATION
-- ==========================
SELECT
  *
FROM
  products
ORDER BY
  price ASC
LIMIT
  25
OFFSET
  25;

-- ==========================
--  Second and third most expensive phones
-- ==========================
SELECT
  name
FROM
  phones
ORDER BY
  price DESC
LIMIT
  2
OFFSET
  1;