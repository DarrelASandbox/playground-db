USE thriftshop;

SELECT
  @@autocommit;

SET
  autocommit = OFF;

-- SELECT
--   *
-- FROM
--   customer_purchases;
-- ALTER TABLE
--   customer_purchases DROP COLUMN customer_id;
-- ALTER TABLE
--   customer_purchases
-- ADD
--   COLUMN purchase_amount DECIMAL(10, 2)
-- AFTER
--   customer_purchase_id;
-- SELECT
--   *
-- FROM
--   inventory;
-- INSERT INTO
--   inventory
-- VALUES
--   (10, 'wolf skin hat', 1);
-- INSERT INTO
--   inventory
-- VALUES
--   (11, 'fur fox skin', 1),
--   (12, 'plaid button up shirt', 8),
--   (13, 'flannel zebra jammies', 6);
-- UPDATE
--   inventory
-- SET
--   number_in_stock = 0 -- sold out
--   -- WHERE inventory_id IN (1,9); -- update inventory_id 1 & 9
-- WHERE
--   item_name = 'mocassins';
DELETE FROM
  inventory
WHERE
  inventory_id = 7;

ROLLBACK;

COMMIT;

ALTER TABLE
  customers
ADD
  PRIMARY KEY (customer_id);

DELETE FROM
  customers
WHERE
  customer_id BETWEEN 1
  AND 6;

ROLLBACK;

TRUNCATE TABLE customers;