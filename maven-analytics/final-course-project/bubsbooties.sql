-- table: customers
-- customer_id
-- first_name
-- last_name
-- email
--
-- table: employees
-- first_name
-- last_name
-- start_date
-- position
--
-- table: products
-- product_id
-- product_name
-- launched_date
--
-- table: customer_purchases
-- customer_purchase_id
-- customer_id
-- product_id
-- purchased_id
-- purchased_at
-- amount_usd
--
DROP SCHEMA bubsbooties;

CREATE SCHEMA IF NOT EXISTS bubsbooties;

USE bubsbooties;

CREATE TABLE IF NOT EXISTS customers (
  customer_id BIGINT NOT NULL,
  first_name VARCHAR(25) NOT NULL,
  last_name VARCHAR(25) NOT NULL,
  email VARCHAR(25) NOT NULL,
  UNIQUE INDEX (email),
  PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS employees (
  employee_id BIGINT NOT NULL,
  first_name VARCHAR(25) NOT NULL,
  last_name VARCHAR(25) NOT NULL,
  position VARCHAR(25) NOT NULL,
  hire_date DATE NOT NULL,
  PRIMARY KEY (employee_id)
);

CREATE TABLE IF NOT EXISTS products (
  product_id BIGINT NOT NULL,
  product_name VARCHAR(25) NOT NULL,
  UNIQUE INDEX (product_name),
  launched_at DATE NOT NULL,
  PRIMARY KEY (product_id)
);

CREATE TABLE IF NOT EXISTS customer_purchases (
  customer_purchases_id BIGINT NOT NULL,
  customer_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  employee_id BIGINT NOT NULL,
  purchased_at TIMESTAMP NOT NULL,
  PRIMARY KEY (customer_purchases_id)
);

ALTER TABLE
  customer_purchases
ADD
  CONSTRAINT `cp_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`customer_id`);

ALTER TABLE
  customer_purchases
ADD
  CONSTRAINT `cp_product_id` FOREIGN KEY (`product_id`) REFERENCES `products`(`product_id`);

ALTER TABLE
  customer_purchases
ADD
  CONSTRAINT `cp_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employees`(`employee_id`);

SELECT
  *
FROM
  customers;

INSERT INTO
  customers
values
  (1, 'Kathleen', 'McPauler', 'xyz@abc.com'),
  (2, 'Landon', 'Oliver', 'qwe@abc.com'),
  (3, 'Ella', 'Grace', 'def@abc.com');

SELECT
  *
FROM
  employees;

INSERT INTO
  employees
values
  (1, 'Tucker', 'Glover', 'manager', '2019-06-01'),
  (2, 'Reily', 'Glover', 'cashier', '2019-09-01'),
  (3, 'Brody', 'Glover', 'salesman', '2019-07-01');

SELECT
  *
FROM
  products;

INSERT INTO
  products
values
  (1, 'Big Gloves', '2019-09-01'),
  (2, 'Medium Gloves', '2019-09-01'),
  (3, 'Small Gloves', '2019-09-01');

SELECT
  *
FROM
  customer_purchases;

INSERT INTO
  customer_purchases
values
  (1, 1, 3, 2, '2019-09-02'),
  (2, 2, 2, 3, '2019-09-03'),
  (3, 1, 1, 1, '2019-09-01');