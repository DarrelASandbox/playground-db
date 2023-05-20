USE thriftshop;

SELECT
  *
FROM
  inventory;

CREATE TRIGGER purchaseUpdateInventory
AFTER
INSERT
  ON customer_purchases FOR EACH ROW
UPDATE
  inventory -- subtracting an item for each purchase
SET
  number_in_stock = number_in_stock - 1
WHERE
  inventory_id = NEW.inventory_id;

INSERT INTO
  customer_purchases
VALUES
  -- invetory_id = 3, velour jumpsuit
  (13, NULL, 3, NULL),
  (14, NULL, 4, NULL) -- inventory_id = 4, house slippers
;