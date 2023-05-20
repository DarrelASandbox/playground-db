USE sloppyjoes;

SELECT
  *
FROM
  staff;

DROP TRIGGER IF EXISTS updateOrdersServed;

CREATE TRIGGER updateOrdersServed
AFTER
INSERT
  ON customer_orders FOR EACH ROW
UPDATE
  staff
SET
  orders_served = orders_served + 1
WHERE
  staff.staff_id = NEW.staff_id;

SELECT
  *
FROM
  staff;

INSERT INTO
  customer_orders
VALUES
  (21, 1, 10.98),
  (22, 2, 5.99),
  (23, 2, 7.99),
  (24, 2, 12.97);

SELECT
  *
FROM
  staff;