-- Generate Data
SELECT
  random(),
  random(),
  trunc(random() * 100);

SELECT
  repeat('Neon ', 5);

SELECT
  generate_series(1, 5);

SELECT
  'Neon' || generate_series(1, 5);

-- [ 'Neon' + str(x) for x in range(1,6) ]
CREATE TABLE textfun(
  content text
);

INSERT INTO textfun(content)
SELECT
  'Neon' || generate_series(1, 5);

SELECT
  *
FROM
  textfun;

DELETE FROM textfun;

-- BTree Index is Default
CREATE INDEX textfun_b ON textfun(content);

SELECT
  pg_relation_size('textfun'),
  pg_indexes_size('textfun');

SELECT
  (
    CASE WHEN (random() < 0.5) THEN
      'https://www.pg4e.com/neon/'
    ELSE
      'https://www.pg4e.com/LEMONS/'
    END) || generate_series(1000, 1005);

INSERT INTO textfun(content)
SELECT
  (
    CASE WHEN (random() < 0.5) THEN
      'https://www.pg4e.com/neon/'
    ELSE
      'https://www.pg4e.com/LEMONS/'
    END) || generate_series(100000, 200000);

SELECT
  pg_relation_size('textfun'),
  pg_indexes_size('textfun');

SELECT
  content
FROM
  textfun
WHERE
  content LIKE '%150000%';

--  https://www.pg4e.com/neon/150000
SELECT
  upper(content)
FROM
  textfun
WHERE
  content LIKE '%150000%';

--  HTTPS://WWW.PG4E.COM/NEON/150000
SELECT
  lower(content)
FROM
  textfun
WHERE
  content LIKE '%150000%';

--  https://www.pg4e.com/neon/150000
SELECT
  RIGHT (content,
    4)
FROM
  textfun
WHERE
  content LIKE '%150000%';

-- 0000
SELECT
  LEFT (content,
    4)
FROM
  textfun
WHERE
  content LIKE '%150000%';

-- http
SELECT
  strpos(content, 'ttps://')
FROM
  textfun
WHERE
  content LIKE '%150000%';

-- 2
SELECT
  substr(content, 2, 4)
FROM
  textfun
WHERE
  content LIKE '%150000%';

-- ttps
SELECT
  split_part(content, '/', 4)
FROM
  textfun
WHERE
  content LIKE '%150000%';

-- neon
SELECT
  translate(content, 'th.p/', 'TH!P_')
FROM
  textfun
WHERE
  content LIKE '%150000%';

--  HTTPs:__www!Pg4e!com_neon_150000
-- LIKE-style wild cards
SELECT
  content
FROM
  textfun
WHERE
  content LIKE '%150000%';

SELECT
  content
FROM
  textfun
WHERE
  content LIKE '%150_00%';

SELECT
  content
FROM
  textfun
WHERE
  content IN ('https://www.pg4e.com/neon/150000', 'https://www.pg4e.com/neon/150001');

-- Don't want to fill up the server
DROP TABLE textfun;

--- Regex
CREATE TABLE em(
  id serial,
  PRIMARY KEY (id),
  email text
);

INSERT INTO em(email)
  VALUES ('csev@umich.edu');

INSERT INTO em(email)
  VALUES ('coleen@umich.edu');

INSERT INTO em(email)
  VALUES ('sally@uiuc.edu');

INSERT INTO em(email)
  VALUES ('ted79@umuc.edu');

INSERT INTO em(email)
  VALUES ('glenn1@apple.com');

INSERT INTO em(email)
  VALUES ('nbody@apple.com');

SELECT
  email
FROM
  em
WHERE
  email ~ 'umich';

SELECT
  email
FROM
  em
WHERE
  email ~ '^c';

SELECT
  email
FROM
  em
WHERE
  email ~ 'edu$';

SELECT
  email
FROM
  em
WHERE
  email ~ '^[gnt]';

SELECT
  email
FROM
  em
WHERE
  email ~ '[0-9]';

SELECT
  email
FROM
  em
WHERE
  email ~ '[0-9][0-9]';

SELECT
  substring(email FROM '[0-9]+')
FROM
  em
WHERE
  email ~ '[0-9]';

SELECT
  substring(email FROM '.+@(.*)$')
FROM
  em;

SELECT DISTINCT
  substring(email FROM '.+@(.*)$')
FROM
  em;

SELECT
  substring(email FROM '.+@(.*)$'),
  count(substring(email FROM '.+@(.*)$'))
FROM
  em
GROUP BY
  substring(email FROM '.+@(.*)$');

SELECT
  *
FROM
  em
WHERE
  substring(email FROM '.+@(.*)$') = 'umich.edu';

CREATE TABLE tw(
  id serial,
  PRIMARY KEY (id),
  tweet text
);

INSERT INTO tw(tweet)
  VALUES ('This is #SQL and #FUN stuff');

INSERT INTO tw(tweet)
  VALUES ('More people should learn #SQL FROM #UMSI');

INSERT INTO tw(tweet)
  VALUES ('#UMSI also teaches #PYTHON');

SELECT
  tweet
FROM
  tw;

SELECT
  id,
  tweet
FROM
  tw
WHERE
  tweet ~ '#SQL';

SELECT
  regexp_matches(tweet, '#([A-Za-z0-9_]+)', 'g')
FROM
  tw;

SELECT DISTINCT
  regexp_matches(tweet, '#([A-Za-z0-9_]+)', 'g')
FROM
  tw;

SELECT
  id,
  regexp_matches(tweet, '#([A-Za-z0-9_]+)', 'g')
FROM
  tw;

-- wget https://www.pg4e.com/lectures/mbox-short.txt
CREATE TABLE mbox(
  line text
);

-- E'\007' is the BEL character and not in the data so each row is one column
\copy mbox FROM 'mbox-short.txt' with delimiter E'\007';
\copy mbox FROM PROGRAM 'wget -q -O - "$@" https://www.pg4e.com/lectures/mbox-short.txt' with delimiter E'\007';
SELECT
  line
FROM
  mbox
WHERE
  line ~ '^From ';

SELECT
  substring(line, ' (.+@[^ ]+) ')
FROM
  mbox
WHERE
  line ~ '^From ';

SELECT
  substring(line, ' (.+@[^ ]+) '),
  count(substring(line, ' (.+@[^ ]+) '))
FROM
  mbox
WHERE
  line ~ '^From '
GROUP BY
  substring(line, ' (.+@[^ ]+) ')
ORDER BY
  count(substring(line, ' (.+@[^ ]+) ')) DESC;

SELECT
  email,
  count(email)
FROM (
  SELECT
    substring(line, ' (.+@[^ ]+) ') AS email
  FROM
    mbox
  WHERE
    line ~ '^From ') AS badsub
GROUP BY
  email
ORDER BY
  count(email) DESC;

--- Advanced Indexes
--- Note these might overrun a class-provided server with a small disk quota
SELECT
  'https://www.pg4e.com/neon/' || trunc(random() * 1000000) || repeat('Lemon', 5) || generate_series(1, 5);

CREATE TABLE cr1(
  id serial,
  url varchar(128) UNIQUE,
  content text
);

INSERT INTO cr1(url)
SELECT
  repeat('Neon', 1000) || generate_series(1, 5000);

CREATE TABLE cr2(
  id serial,
  url text,
  content text
);

INSERT INTO cr2(url)
SELECT
  repeat('Neon', 1000) || generate_series(1, 5000);

SELECT
  pg_relation_size('cr2'),
  pg_indexes_size('cr2');

CREATE UNIQUE INDEX cr2_unique ON cr2(url);

SELECT
  pg_relation_size('cr2'),
  pg_indexes_size('cr2');

DROP INDEX cr2_unique;

SELECT
  pg_relation_size('cr2'),
  pg_indexes_size('cr2');

CREATE UNIQUE INDEX cr2_md5 ON cr2(md5(url));

SELECT
  pg_relation_size('cr2'),
  pg_indexes_size('cr2');

EXPLAIN
SELECT
  *
FROM
  cr2
WHERE
  url = 'lemons';

EXPLAIN
SELECT
  *
FROM
  cr2
WHERE
  md5(url) = md5('lemons');

DROP INDEX cr2_md5;

CREATE UNIQUE INDEX cr2_sha256 ON cr2(sha256(url::bytea));

EXPLAIN
SELECT
  *
FROM
  cr2
WHERE
  sha256(url::bytea) = sha256('bob'::bytea);

CREATE TABLE cr3(
  id serial,
  url text,
  url_md5 uuid UNIQUE,
  content text
);

INSERT INTO cr3(url)
SELECT
  repeat('Neon', 1000) || generate_series(1, 5000);

SELECT
  pg_relation_size('cr3'),
  pg_indexes_size('cr3');

UPDATE
  cr3
SET
  url_md5 = md5(url)::uuid;

SELECT
  pg_relation_size('cr3'),
  pg_indexes_size('cr3');

EXPLAIN ANALYZE
SELECT
  *
FROM
  cr3
WHERE
  url_md5 = md5('lemons')::uuid;

CREATE TABLE cr4(
  id serial,
  url text,
  content text
);

INSERT INTO cr4(url)
SELECT
  repeat('Neon', 1000) || generate_series(1, 5000);

CREATE INDEX cr4_hash ON cr4 USING HASH (url);

SELECT
  pg_relation_size('cr4'),
  pg_indexes_size('cr4');

EXPLAIN ANALYZE
SELECT
  *
FROM
  cr5
WHERE
  url = 'lemons';

-- Drop these tables to make sure not to overrun your server
DROP TABLE cr1;

DROP TABLE cr2;

DROP TABLE cr3;

DROP TABLE cr4;

DROP TABLE cr5;

