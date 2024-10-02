-- mbox
-- https://www.pg4e.com/lectures/mbox-short.txt
CREATE TABLE mbox(
  line text
);

-- E'\007' is the BEL character and not in the data so each row is one column
-- \copy mbox FROM 'sql/postgresql/postgresql-for-everybody-specialization/intermediate-postgresql/mbox-short.txt' with delimiter E'\007';
-- \copy mbox FROM PROGRAM 'wget -q -O - "$@" https://www.pg4e.com/lectures/mbox-short.txt' with delimiter E'\007';
SELECT
  COUNT(*)
FROM
  mbox;

-- Assignment
/*
readonly=# \d+ taxdata
 Column  |          Type          |
----------+------------------------+
 id       | integer                |
 ein      | integer                |
 name     | character varying(255) |
 year     | integer                |
 revenue  | bigint                 |
 expenses | bigint                 |
 purpose  | text                   |
 ptid     | character varying(255) |
 ptname   | character varying(255) |
 city     | character varying(255) |
 state    | character varying(255) |
 url      | character varying(255) |
 */
-- Lines where the very first character was an upper case character letter
SELECT
  purpose
FROM
  taxdata
WHERE
  purpose ~ '^[A-Z]'
ORDER BY
  purpose DESC
LIMIT 3;

-- Lines that are all upper case letters and spaces and nothing else
SELECT
  purpose
FROM
  taxdata
WHERE
  purpose ~ '^[A-Z ]+$'
ORDER BY
  purpose DESC
LIMIT 3;

