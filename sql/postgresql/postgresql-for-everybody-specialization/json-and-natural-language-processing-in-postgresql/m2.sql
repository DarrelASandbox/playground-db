-- Building a string array-based GIN index
CREATE TABLE docs03(
  id serial,
  doc text,
  PRIMARY KEY (id)
);

CREATE INDEX array03 ON docs03 USING gin(string_to_array(lower(doc), ' ') array_ops);

INSERT INTO docs03(doc)
  VALUES ('What is a program'),
('The definition of a program at its most basic is a'),
('sequence of Python statements that have been crafted to do something'),
('Even our simple hellopy script is a program It is a'),
('oneline program and is not particularly useful but in the strictest'),
('definition it is a Python program'),
('It might be easiest to understand what a program is by thinking about a'),
('problem that a program might be built to solve and then looking at a'),
('program that would solve that problem'),
('Lets say you are doing Social Computing research on Facebook posts and');

INSERT INTO docs03(doc)
SELECT
  'Neon ' || generate_series(10000, 20000);

SELECT
  id,
  doc
FROM
  docs03
WHERE
  '{particularly}' <@ string_to_array(lower(doc), ' ');

EXPLAIN
SELECT
  id,
  doc
FROM
  docs03
WHERE
  '{particularly}' <@ string_to_array(lower(doc), ' ');

-- Identify the Name of the Index
SELECT
  indexname,
  indexdef
FROM
  pg_indexes
WHERE
  tablename = 'docs03';

DROP INDEX IF EXISTS array03;

-- Building a tsvector-based full text GIN index
-- If you already have the docs03 filled with the correct rows, you can just add the new index to the table.
-- Optional
CREATE TABLE docs03(
  id serial,
  doc text,
  PRIMARY KEY (id)
);

CREATE INDEX fulltext03 ON docs03 USING gin(to_tsvector('english', doc));

-- Optional
INSERT INTO docs03(doc)
  VALUES ('What is a program'),
('The definition of a program at its most basic is a'),
('sequence of Python statements that have been crafted to do something'),
('Even our simple hellopy script is a program It is a'),
('oneline program and is not particularly useful but in the strictest'),
('definition it is a Python program'),
('It might be easiest to understand what a program is by thinking about a'),
('problem that a program might be built to solve and then looking at a'),
('program that would solve that problem'),
('Lets say you are doing Social Computing research on Facebook posts and');

SELECT
  id,
  doc
FROM
  docs03
WHERE
  to_tsquery('english', 'particularly') @@ to_tsvector('english', doc);

EXPLAIN
SELECT
  id,
  doc
FROM
  docs03
WHERE
  to_tsquery('english', 'particularly') @@ to_tsvector('english', doc);

