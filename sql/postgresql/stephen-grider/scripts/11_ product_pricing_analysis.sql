-- ==========================
-- Product Weight Adjustment Query
-- Description: Retrieves product names, weights, and adjusted weights where the minimum weight is considered as 30.
-- ==========================
SELECT
  name,
  weight,
  GREATEST (30, 2 * weight)
FROM
  products;

-- ==========================
-- Discounted Price Query
-- Description: Retrieves product names, prices, and calculates discounted prices not exceeding 400.
-- ==========================
SELECT
  name,
  price,
  LEAST (price * 0.5, 400)
FROM
  products;

-- ==========================
-- Price Category Assignment Query
-- Description: Categorizes products into 'high', 'medium', or 'cheap' based on their price.
-- ==========================
SELECT
  name,
  price,
  CASE
    WHEN price > 500 THEN 'high'
    WHEN price > 300 THEN 'medium'
    ELSE 'cheap'
  END
FROM
  products;