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

ALTER TABLE pg4e_debug
  ADD COLUMN neon641 INTEGER;

SELECT
  neon641
FROM
  pg4e_debug
LIMIT 1;

SELECT DISTINCT
  state
FROM
  taxdata
ORDER BY
  state ASC
LIMIT 5;

CREATE TABLE keyvalue(
  id serial,
  key VARCHAR(128) UNIQUE,
  value varchar(128) UNIQUE,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id)
);

CREATE OR REPLACE FUNCTION trigger_set_timestamp()
  RETURNS TRIGGER
  AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON keyvalue
  FOR EACH ROW
  EXECUTE PROCEDURE trigger_set_timestamp();

\d -- List of relations
\df --List of functions
\dy -- List of event triggers
DROP FUNCTION IF EXISTS trigger_set_timestamp() CASCADE;

DROP SEQUENCE IF EXISTS keyvalue_id_seq CASCADE;

