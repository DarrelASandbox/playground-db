-- ==========================
-- Subquery
-- ==========================
SELECT
  name,
  price
FROM
  products
WHERE
  price > (
    SELECT
      MAX(price)
    FROM
      products
    WHERE
      department = 'Toys'
  );

-- ==========================
-- Any subquery that results in a single value
-- ==========================
SELECT
  name,
  price,
  (
    SELECT
      price
    FROM
      products
    WHERE
      id = 3
  ) AS id_3_price
FROM
  products
WHERE
  price > 867;

-- ==========================
-- Embedding in SELECT
-- ==========================
SELECT
  name,
  price,
  price / (
    SELECT
      MAX(price)
    FROM
      phones
  ) AS price_ratio
FROM
  phones;

-- ==========================
-- Without over complicating
-- ==========================
SELECT
  name,
  price / weight AS price_weight_ratio
FROM
  products
WHERE
  price / weight > 5;

-- ==========================
-- Any subquery, so long as the outer 
-- SELECTs/ WHEREs/ etc are compatible
-- ==========================
SELECT
  name,
  price_weight_ratio
FROM
  (
    SELECT
      name,
      price / weight AS price_weight_ratio
    FROM
      products
  ) AS p
WHERE
  price_weight_ratio > 5;

-- ==========================
-- Overcomplication for the task of 
-- retrieving a single aggregated value.
-- ==========================
SELECT
  *
FROM
  (
    SELECT
      MAX(price)
    FROM
      products
  ) AS p;

-- ==========================
-- Subquery in a FROM claus
-- ==========================
SELECT
  AVG(p.order_count)
FROM
  (
    SELECT
      user_id,
      COUNT(*) AS order_count
    FROM
      orders
    GROUP BY
      user_id
  ) as p;

-- ==========================
-- Subquery From's
-- ==========================
SELECT
  MAX(average_price) AS max_average_price
FROM
  (
    SELECT
      manufacturer,
      AVG(price) as average_price
    FROM
      phones
    GROUP BY
      manufacturer
  ) AS p;

-- ==========================
-- Subquery in a JOIN clause
-- (Can be done without subquery)
-- ==========================
SELECT
  first_name
FROM
  users
  JOIN (
    SELECT
      user_id
    FROM
      orders
    WHERE
      product_id = 3
  ) AS o ON o.user_id = user_id;

-- ==========================
-- Without subquery
-- ==========================
SELECT
  first_name
FROM
  users
  JOIN orders ON orders.user_id = user_id
WHERE
  product_id = 3;

-- ==========================
-- Another example
-- ==========================
/* 
Using a subquery in a `JOIN` clause is often used when you need to aggregate data before joining, or when the subquery is complex and you want to make the final `SELECT` statement simpler to read. Here's an example that demonstrates using a subquery with a `JOIN` clause that might not be as easily rewritten without the subquery. This example involves an aggregation within the subquery as shown below.

In this example, the subquery is aggregating the number of orders per user before joining with the users table. This can be especially useful if you need to perform further filtering or calculations on the aggregated data in the outer query that would be more complex to do directly with a GROUP BY in the main query. For instance, you might want to JOIN another table or filter on the aggregated data.
 */
-- Using a subquery to aggregate data before joining
SELECT
  u.first_name,
  u.last_name,
  co.total_orders
FROM
  users u
  JOIN (
    SELECT
      id,
      COUNT(*) AS total_orders
    FROM
      orders
    GROUP BY
      id
  ) AS co ON u.id = co.id;

-- ==========================
-- Subqueries with WHERE clause
-- ==========================
SELECT
  id
FROM
  orders
WHERE
  product_id IN (
    SELECT
      id
    FROM
      products
    WHERE
      price / weight > 50
  );

-- ==========================
-- Without subquery
-- ==========================
SELECT
  orders.id
FROM
  orders
  JOIN products ON products.id = orders.product_id
WHERE
  price / weight > 50;

-- ==========================
-- Subquery WHERE
-- ==========================
SELECT
  name,
  price
FROM
  phones
WHERE
  price > (
    SELECT
      price
    FROM
      phones
    WHERE
      name = 'S5620 Monte'
  );

-- ==========================
-- NOT IN Operator
-- ==========================
SELECT
  department
FROM
  products
WHERE
  department NOT IN (
    SELECT
      department
    FROM
      products
    WHERE
      price < 100
  );

-- ==========================
-- Operator with ALL
-- ==========================
SELECT
  name,
  department,
  price
FROM
  products
WHERE
  price > ALL (
    SELECT
      price
    FROM
      products
    WHERE
      department = 'Industrial'
  );

-- ==========================
-- Using MAX instead
-- ==========================
SELECT
  (name, department, price)
FROM
  products
WHERE
  price > (
    SELECT
      MAX(price)
    FROM
      products
    WHERE
      department = 'Industrial'
  );

-- ==========================
-- Operator with SOME
-- ==========================
SELECT
  name,
  department,
  price
FROM
  products
WHERE
  price > SOME (
    SELECT
      price
    FROM
      products
    WHERE
      department = 'Industrial'
  );

-- ==========================
-- MORE PRACTICE
-- ==========================
SELECT
  name
FROM
  phones
WHERE
  price > All (
    SELECT
      price
    FROM
      phones
    WHERE
      manufacturer = 'Samsung'
  );

-- ==========================
-- Or do this
-- ==========================
SELECT
  name
FROM
  phones
WHERE
  price > (
    SELECT
      MAX(price)
    FROM
      phones
    WHERE
      manufacturer = 'Samsung'
  );