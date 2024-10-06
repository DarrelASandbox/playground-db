-- Running simple.py
SELECT
  line
FROM
  pythonfun
WHERE
  line LIKE 'Have a nice%';

-- Inserting a sequence of numbers in Python
CREATE TABLE pythonseq(
  iter integer,
  val integer
);

