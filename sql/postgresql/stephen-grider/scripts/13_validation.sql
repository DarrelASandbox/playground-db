CREATE TABLE
  products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40),
    department VARCHAR(40),
    price INTEGER,
    weight INTEGER
  );

INSERT INTO
  products (name, department, price, weight)
VALUES
  ('Shirt', 'Clothes', 20, 1);

INSERT INTO
  products (name, department, weight)
VALUES
  ('Pants', 'Clothes', 3);

UPDATE products
SET
  price = 9999
WHERE
  price IS NULL;

-- ==========================
-- Row-Level Validation (NOT NULL)
-- ==========================
ALTER TABLE products
ALTER COLUMN price
SET NOT NULL;

ALTER TABLE products
ALTER COLUMN price
SET DEFAULT 9999;

INSERT INTO
  products (name, department, weight)
VALUES
  ('Gloves', 'Tools', 1);

ALTER TABLE products
ADD UNIQUE (name);

ALTER TABLE products
DROP CONSTRAINT products_name_key;

-- ==========================
-- Multi-Column Uniqueness
-- ==========================
ALTER TABLE products
ADD UNIQUE (name, department);

INSERT INTO
  products (name, department, price, weight)
VALUES
  ('Shirt', 'Housewares', 2, 2);

-- ==========================
-- Row-Level Validation (CHECK)
-- ==========================
ALTER TABLE products
ADD CHECK (price > 0);

INSERT INTO
  products (name, department, price, weight)
VALUES
  ('Belt', 'Housewares', -1, 2);

SELECT
  *
FROM
  products;

-- ==========================
-- Set CONSTRAINTs when creating table
-- ==========================
CREATE TABLE
  products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    department VARCHAR(40) NOT NULL,
    price INTEGER CHECK (price > 0),
    weight INTEGER DEFAULT 10,
    UNIQUE (name, department)
  );

INSERT INTO
  products (name, department, price, weight)
VALUES
  ('Shirt', 'Clothes', 20, 1),
  ('Pants', 'Clothes', 20, 1),
  ('Gloves', 'Tools', 10, 1);

-- ==========================
-- Checks Over Multiple Columns
-- ==========================
CREATE TABLE
  orders (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    est_delivery TIMESTAMP NOT NULL,
    CHECK (created_at < est_delivery)
  );

INSERT INTO
  orders (name, created_at, est_delivery)
VALUES
  (
    'Shirt',
    '2000-NOV-20 01:00AM',
    '2000-NOV-21 01:00AM'
  );

SELECT
  *
FROM
  orders;