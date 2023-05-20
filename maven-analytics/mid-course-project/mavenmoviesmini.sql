USE mavenmoviesmini;

SELECT
  *
FROM
  inventory_non_normalized;

-- inventory (inventory_id, film_id, store_id)
-- film (film_id, title, description, release_year, rental_rate, rating)
-- store (store_id, store_manager_first_name, store_manager_last_name, store_address, store_city, store_district)
SELECT
  *
from
  inventory_non_normalized;

CREATE SCHEMA IF NOT EXISTS mavenmoviesmini_normalized;

USE mavenmoviesmini_normalized;

CREATE TABLE IF NOT EXISTS inventory (
  inventory_id INT NOT NULL,
  film_id INT NOT NULL,
  store_id INT NOT NULL,
  PRIMARY KEY (inventory_id)
);

CREATE TABLE IF NOT EXISTS film (
  film_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  release_year INT NOT NULL,
  rental_rate DECIMAL(6, 2) NOT NULL,
  rating VARCHAR(9) NOT NULL,
  PRIMARY KEY (film_id)
);

CREATE TABLE IF NOT EXISTS store (
  store_id INT NOT NULL,
  store_manager_first_name VARCHAR(20) NOT NULL,
  store_manager_last_name VARCHAR(20) NOT NULL,
  store_address VARCHAR(55) NOT NULL,
  store_city VARCHAR(55) NOT NULL,
  store_district VARCHAR(55) NOT NULL,
  PRIMARY KEY (store_id)
);

INSERT INTO
  inventory (inventory_id, film_id, store_id)
SELECT
  DISTINCT inventory_id,
  film_id,
  store_id
FROM
  mavenmoviesmini.inventory_non_normalized;

SELECT
  *
FROM
  inventory;

INSERT INTO
  film (
    film_id,
    title,
    description,
    release_year,
    rental_rate,
    rating
  )
SELECT
  DISTINCT film_id,
  title,
  description,
  release_year,
  rental_rate,
  rating
FROM
  mavenmoviesmini.inventory_non_normalized;

SELECT
  *
FROM
  film;

INSERT INTO
  store (
    store_id,
    store_manager_first_name,
    store_manager_last_name,
    store_address,
    store_city,
    store_district
  )
SELECT
  DISTINCT store_id,
  store_manager_first_name,
  store_manager_last_name,
  store_address,
  store_city,
  store_district
FROM
  mavenmoviesmini.inventory_non_normalized;

SELECT
  *
FROM
  store;

ALTER TABLE
  inventory
ADD
  CONSTRAINT `inventory_film_id` FOREIGN KEY (`film_id`) REFERENCES `film`(`film_id`);

ALTER TABLE
  inventory
ADD
  CONSTRAINT `inventory_store_id` FOREIGN KEY (`store_id`) REFERENCES `Store`(`store_id`);