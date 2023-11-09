-- ==========================
-- Retrieve distinct department and name pairs from products
-- ==========================
SELECT DISTINCT
  department,
  name
FROM
  products;

-- ==========================
-- Count the number of unique departments in products
-- ==========================
SELECT DISTINCT
  COUNT(department)
FROM
  products;

-- ==========================
-- Count the number of unique phone manufacturers
-- ==========================
SELECT
  COUNT(DISTINCT manufacturer)
FROM
  phones;