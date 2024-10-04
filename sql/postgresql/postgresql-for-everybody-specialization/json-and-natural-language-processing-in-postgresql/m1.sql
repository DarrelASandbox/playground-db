-- Building an Inverted Index using SQL
CREATE TABLE pg4e_debug(
  id serial,
  query varchar(4096),
  result varchar(4096),
  created_at timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);

SELECT
  query,
  result,
  created_at
FROM
  pg4e_debug;

CREATE TABLE pg4e_result(
  id serial,
  link_id integer UNIQUE,
  score float,
  title varchar(4096),
  note varchar(4096),
  debug_log varchar(8192),
  created_at timestamp DEFAULT CURRENT_TIMESTAMP,
  updated_at timestamp
);

CREATE TABLE docs01(
  id serial,
  doc text,
  PRIMARY KEY (id)
);

CREATE TABLE invert01(
  keyword text,
  doc_id integer REFERENCES docs01(id) ON DELETE CASCADE
);

INSERT INTO docs01(doc)
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

WITH tokenized_docs01 AS (
  SELECT
    id AS doc_id,
    LOWER(unnest(string_to_array(doc, ' '))) AS word
  FROM
    docs01)
  INSERT INTO invert01(keyword, doc_id)
  SELECT DISTINCT
    word,
    doc_id
  FROM
    tokenized_docs01
  ORDER BY
    word,
    doc_id;

-- Without CTEs
INSERT INTO invert01(keyword, doc_id)
SELECT DISTINCT
  LOWER(unnest(string_to_array(doc, ' '))) AS keyword,
  id AS doc_id
FROM
  docs01
ORDER BY
  keyword,
  doc_id;

SELECT
  keyword,
  doc_id
FROM
  invert01
ORDER BY
  keyword,
  doc_id
LIMIT 10;


/* 
keyword    |  doc_id
-----------+--------
a          |    1    
a          |    2    
a          |    4    
a          |    6    
a          |    7    
a          |    8    
about      |    7    
and        |    5    
and        |    8    
and        |    10  
 */
--
--
-- Building an Inverted Index with stop words using SQL
CREATE TABLE docs02(
  id serial,
  doc text,
  PRIMARY KEY (id)
);

CREATE TABLE invert02(
  keyword text,
  doc_id integer REFERENCES docs02(id) ON DELETE CASCADE
);

-- If you already have the above tables created and the documents inserted from a prior assignment,
-- you can just delete all the rows from the reverse index and
-- recreate them following the rules of stop words:
DELETE FROM invert02;

INSERT INTO docs02(doc)
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

CREATE TABLE stop_words(
  word text UNIQUE
);

INSERT INTO stop_words(word)
  VALUES ('i'),
('a'),
('about'),
('an'),
('are'),
('as'),
('at'),
('be'),
('by'),
('com'),
('for'),
('from'),
('how'),
('in'),
('is'),
('it'),
('of'),
('on'),
('or'),
('that'),
('the'),
('this'),
('to'),
('was'),
('what'),
('when'),
('where'),
('who'),
('will'),
('with');

-- First draft
WITH tokenized_docs02 AS (
  SELECT
    id AS doc_id,
    LOWER(unnest(string_to_array(doc, ' '))) AS word
  FROM
    docs02
),
filtered_tokens AS (
  SELECT DISTINCT
    word,
    doc_id
  FROM
    tokenized_docs02
  WHERE
    word NOT IN (
      SELECT
        word
      FROM
        stop_words))
  INSERT INTO invert02(keyword, doc_id)
  SELECT DISTINCT
    word,
    doc_id
  FROM
    filtered_tokens
  ORDER BY
    word,
    doc_id;

-- Improved query
INSERT INTO invert02(keyword, doc_id)
SELECT DISTINCT
  LOWER(word) AS keyword,
  doc_id
FROM (
  SELECT
    id AS doc_id,
    unnest(string_to_array(doc, ' ')) AS word
  FROM
    docs02) AS tokenized
WHERE
  LOWER(word)
  NOT IN (
    SELECT
      word
    FROM
      stop_words)
ORDER BY
  keyword,
  doc_id;

SELECT
  keyword,
  doc_id
FROM
  invert02
ORDER BY
  keyword,
  doc_id
LIMIT 10;


/* 
keyword    |  doc_id
-----------+--------
and        |    5    
and        |    8    
and        |    10   
basic      |    2    
been       |    3    
built      |    8    
but        |    5    
computing  |    10   
crafted    |    3    
definition |    2  
 */
