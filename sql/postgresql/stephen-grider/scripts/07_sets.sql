-- ==========================
-- Handling Sets with UNION
-- ==========================
(
  SELECT
    *
  FROM
    products
  ORDER BY
    price DESC
  LIMIT
    4
)
UNION
(
  SELECT
    *
  FROM
    products
  ORDER BY
    price / weight DESC
  LIMIT
    4
);

-- ==========================
-- Commonalities with INTERSECT
-- ==========================
(
  SELECT
    *
  FROM
    products
  ORDER BY
    price DESC
  LIMIT
    4
)
INTERSECT
(
  SELECT
    *
  FROM
    products
  ORDER BY
    price / weight DESC
  LIMIT
    4
);

-- ==========================
-- Remove Commonalities with EXCEPT 
-- ==========================
(
  SELECT
    *
  FROM
    products
  ORDER BY
    price DESC
  LIMIT
    4
)
EXCEPT
(
  SELECT
    *
  FROM
    products
  ORDER BY
    price / weight DESC
  LIMIT
    4
);

-- ==========================
-- 
-- ==========================
SELECT
  manufacturer
FROM
  phones
WHERE
  price < 170
UNION
SELECT
  manufacturer
FROM
  phones
GROUP BY
  manufacturer
HAVING
  COUNT(*) > 2