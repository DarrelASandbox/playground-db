-- ==========================
-- Correlated subqueries
-- ==========================
SELECT
  name,
  department,
  price
FROM
  products AS p1
WHERE
  p1.price = (
    SELECT
      MAX(price)
    FROM
      products AS p2
    WHERE
      p1.department = p2.department
  )
ORDER BY
  p1.department,
  p1.name,
  p1.price;

-- ==========================
-- Query to count the number of orders for each product
-- ==========================
SELECT
  p1.name,
  (
    SELECT
      COUNT(*)
    FROM
      orders AS o1
    WHERE
      o1.product_id = p1
  ) AS num_orders
FROM
  products AS p1;

-- ==========================
-- Query to select the minimum, maximum and average price of products
-- ==========================
SELECT
  (
    SELECT
      MIN(price)
    FROM
      products
  ) as min_price,
  (
    SELECT
      MAX(price)
    FROM
      products
  ) AS max_price,
  (
    SELECT
      AVG(price)
    FROM
      products
  ) AS avg_price;