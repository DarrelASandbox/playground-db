CREATE SCHEMA myfirstcodeschema;

USE myfirstcodeschema;

CREATE TABLE new_table (
  id BIGINT NOT NULL,
  char_field VARCHAR(50),
  text_field TEXT,
  created_at TIMESTAMP,
  PRIMARY KEY (id)
);

-- SELECT * FROM new_table;
SELECT
  id,
  created_at
FROM
  new_table;

DROP SCHEMA myfirstcodeschema