-- psql -h pg.pg4e.com -p 5432 -U pg4e_3e78b32943 pg4e_3e78b32943
-- The pg4e_debug table will let you see the queries that were
-- run by the auto grader as it is grading your assignment.
CREATE TABLE
  pg4e_debug (
    id SERIAL,
    query VARCHAR(4096),
    result VARCHAR(4096),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
  );

-- You can view the contents of this table after running the autograder with this command:
SELECT
  query,
  result,
  created_at
FROM
  pg4e_debug;

-- CREATE TABLE (pg4e_result)
CREATE TABLE
  pg4e_result (
    id SERIAL,
    link_id INTEGER UNIQUE,
    score FLOAT,
    title VARCHAR(4096),
    note VARCHAR(4096),
    debug_log VARCHAR(8192),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
  );

--------------------------------------
-- Inserting Some Data into a Table --
--------------------------------------
CREATE TABLE
  ages (name VARCHAR(128), age INTEGER);

DELETE FROM ages;

INSERT INTO
  ages (name, age)
VALUES
  ('Garry', 36);

INSERT INTO
  ages (name, age)
VALUES
  ('Haydon', 29);

INSERT INTO
  ages (name, age)
VALUES
  ('Kurtis', 16);

INSERT INTO
  ages (name, age)
VALUES
  ('Lucas', 21);

INSERT INTO
  ages (name, age)
VALUES
  ('Rio', 31);