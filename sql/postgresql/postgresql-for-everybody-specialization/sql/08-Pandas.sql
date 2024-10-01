SELECT
  id,
  body -> 'species' ->> 'name'
FROM
  pokeapi
LIMIT 1;

