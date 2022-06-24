CREATE SCHEMA publishers_spendings DEFAULT CHARSET utf8mb4;

USE publishers_spendings;

CREATE TABLE publishers (
	publisher_id INT,
  publisher_name VARCHAR(65),
  PRIMARY KEY (publisher_id)
);

SELECT * FROM publishers;

CREATE TABLE spendings (
  publisher_spend_id VARCHAR(45) NOT NULL,
	publisher_id INT NOT NULL,
  month DATE NOT NULL,
  spendings DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (publisher_spend_id)
);

SELECT * FROM spendings;