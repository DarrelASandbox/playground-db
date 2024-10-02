CREATE TABLE bigtext(
  content text
);

INSERT INTO bigtext(content)
SELECT
  'This is record number ' || n || ' of quite a few text records.'
FROM
  generate_series(100000, 199999) n
RETURNING
  *;

