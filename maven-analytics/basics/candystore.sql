USE candystore;

-- SELECT * FROM candy_products;
SELECT
  *
FROM
  customer_reviews;

SELECT
  *
FROM
  employees;

-- ALTER TABLE
--   employees -- DROP COLUMN avg_customer_rating;
-- ADD
--   COLUMN avg_customer_rating DECIMAL(10, 1)
-- AFTER
--   position;
-- INSERT INTO
--   employees
-- VALUES
--   (7, 'Charles', 'Munger', '2020-03-15', NULL, 5.0),
--   (8, 'William', 'Gates', '2020-03-15', NULL, 5.0);

-- UPDATE
--   employees
-- SET
--   avg_customer_rating = (
--     case
--       WHEN employee_id = 1 THEN 4.8
--       WHEN employee_id = 2 THEN 4.6
--       WHEN employee_id = 3 THEN 4.75
--       WHEN employee_id = 4 THEN 4.9
--       WHEN employee_id = 5 THEN 4.75
--       WHEN employee_id = 6 THEN 4.2
--     end
--   )
UPDATE
  employees
SET
  avg_customer_rating = 4.8
WHERE
  employee_id = 1;

UPDATE
  employees
SET
  avg_customer_rating = 4.6
WHERE
  employee_id = 2;

UPDATE
  employees
SET
  avg_customer_rating = 4.75
WHERE
  employee_id = 3;

UPDATE
  employees
SET
  avg_customer_rating = 4.9
WHERE
  employee_id = 4;

UPDATE
  employees
SET
  avg_customer_rating = 4.75
WHERE
  employee_id = 5;

UPDATE
  employees
SET
  avg_customer_rating = 4.2
WHERE
  employee_id = 6;