-- Create TABLEs account, post, comment and fav
-- cd to sql/postgresql/postgresql-for-everybody-specialization
\i sql/03-Techniques-Load.sql
SELECT
  *
FROM
  post;

-- Create TABLEs xy_raw, y and xy
\copy xy_raw(x,y) FROM 'csv/03-Techniques.csv' WITH DELIMITER ',' CSV;
SELECT
  *
FROM
  xy_raw;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-- Musical Tracks Many-to-One
CREATE TABLE album(
  id serial,
  title varchar(128) UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE track(
  id serial,
  title varchar(128),
  len integer,
  rating integer,
  count integer,
  album_id integer REFERENCES album(id) ON DELETE CASCADE,
  UNIQUE (title, album_id),
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS track_raw;

CREATE TABLE track_raw(
  title text,
  artist text,
  album text,
  album_id integer,
  count integer,
  rating integer,
  len integer
);

SELECT
  *
FROM
  track_raw;

\copy track_raw(title, artist, album, album_id, count,rating) FROM 'csv/library.csv' WITH DELIMITER ',' CSV;
--
INSERT INTO album(title)
SELECT DISTINCT
  album
FROM
  track_raw;

SELECT
  pg_get_serial_sequence('album', 'id') AS sequence_name;

ALTER SEQUENCE public.album_id_seq
  RESTART WITH 1;

UPDATE
  track_raw
SET
  album_id =(
    SELECT
      album.id
    FROM
      album
    WHERE
      album.title = track_raw.album);

SELECT
  column_name,
  data_type,
  is_nullable,
  column_default
FROM
  information_schema.columns
WHERE
  table_name = 'track_raw';

SELECT
  artist,
  album
FROM
  track_raw;

INSERT INTO track(title, album_id)
SELECT
  title,
  album_id
FROM
  track_raw;

SELECT
  track.title,
  album.title
FROM
  track
  JOIN album ON track.album_id = album.id
ORDER BY
  track.title
LIMIT 3;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-- Unesco Heritage Sites Many-to-One
DROP TABLE unesco_raw;

CREATE TABLE unesco_raw(
  name text,
  description text,
  justification text,
  year integer,
  longitude float,
  latitude float,
  area_hectares float,
  category text,
  category_id integer,
  state text,
  state_id integer,
  region text,
  region_id integer,
  iso text,
  iso_id integer
);

SELECT
  COUNT(DISTINCT name) AS unique_name_count,
  COUNT(DISTINCT category) AS unique_category_count,
  COUNT(DISTINCT state) AS unique_state_count,
  COUNT(DISTINCT region) AS unique_region_count,
  COUNT(DISTINCT iso) AS unique_iso_count
FROM
  unesco_raw;

SELECT
  MAX(LENGTH(name)) AS max_name_length,
  MAX(LENGTH(category)) AS category,
  MAX(LENGTH(state)) AS max_state_length,
  MAX(LENGTH(region)) AS max_region_length,
  MAX(LENGTH(iso)) AS max_iso_length
FROM
  unesco_raw;

CREATE TABLE unesco(
  id serial,
  name varchar(130) UNIQUE,
  year integer,
  category_id integer REFERENCES category(id) ON DELETE CASCADE,
  state_id integer REFERENCES state(id) ON DELETE CASCADE,
  region_id integer REFERENCES region(id) ON DELETE CASCADE,
  iso_id integer REFERENCES iso(id) ON DELETE CASCADE,
  PRIMARY KEY (id)
);

CREATE TABLE category(
  id serial,
  name varchar(128) UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE state(
  id serial,
  name varchar(128) UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE region(
  id serial,
  name varchar(128) UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE iso(
  id serial,
  name varchar(128) UNIQUE,
  PRIMARY KEY (id)
);

-- Adding HEADER causes the CSV loader to skip the first line in the CSV file.
\copy unesco_raw(name,description,justification,year,longitude,latitude,area_hectares,category,state,region,iso) FROM 'csv/whc-sites-2018-small.csv' WITH DELIMITER ',' CSV HEADER;
--
INSERT INTO unesco(name, year)
SELECT
  name,
  year
FROM
  unesco_raw;

INSERT INTO category(name)
SELECT DISTINCT
  category
FROM
  unesco_raw;

UPDATE
  unesco_raw
SET
  category_id =(
    SELECT
      category.id
    FROM
      category
    WHERE
      category.name = unesco_raw.category);

INSERT INTO state(name)
SELECT DISTINCT
  state
FROM
  unesco_raw;

UPDATE
  unesco_raw
SET
  state_id =(
    SELECT
      state.id
    FROM
      state
    WHERE
      state.name = unesco_raw.state);

INSERT INTO region(name)
SELECT DISTINCT
  region
FROM
  unesco_raw;

UPDATE
  unesco_raw
SET
  region_id =(
    SELECT
      region.id
    FROM
      region
    WHERE
      region.name = unesco_raw.region);

INSERT INTO iso(name)
SELECT DISTINCT
  iso
FROM
  unesco_raw;

UPDATE
  unesco_raw
SET
  iso_id =(
    SELECT
      iso.id
    FROM
      iso
    WHERE
      iso.name = unesco_raw.iso);

INSERT INTO unesco(name, year, category_id, state_id, region_id, iso_id)
SELECT
  name,
  year,
  category_id,
  state_id,
  region_id,
  iso_id
FROM
  unesco_raw;

SELECT
  unesco.name,
  year,
  category.name,
  state.name,
  region.name,
  iso.name
FROM
  unesco
  JOIN category ON unesco.category_id = category.id
  JOIN iso ON unesco.iso_id = iso.id
  JOIN state ON unesco.state_id = state.id
  JOIN region ON unesco.region_id = region.id
ORDER BY
  category.name,
  unesco.name
LIMIT 3;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-- Musical Track Database plus Artists
DROP TABLE album CASCADE;

CREATE TABLE album(
  id serial,
  title varchar(128) UNIQUE,
  PRIMARY KEY (id)
);

DROP TABLE track CASCADE;

CREATE TABLE track(
  id serial,
  title text,
  artist text,
  album text,
  album_id integer REFERENCES album(id) ON DELETE CASCADE,
  count integer,
  rating integer,
  len integer,
  PRIMARY KEY (id)
);

DROP TABLE artist CASCADE;

CREATE TABLE artist(
  id serial,
  name varchar(128) UNIQUE,
  PRIMARY KEY (id)
);

DROP TABLE tracktoartist CASCADE;

CREATE TABLE tracktoartist(
  id serial,
  track varchar(128),
  track_id integer REFERENCES track(id) ON DELETE CASCADE,
  artist varchar(128),
  artist_id integer REFERENCES artist(id) ON DELETE CASCADE,
  PRIMARY KEY (id)
);

\copy track(title,artist,album,count,rating,len) FROM 'csv/library.csv' WITH DELIMITER ',' CSV;
--
-- This step extracts unique album names from the track table and inserts them into the album table.
-- This is necessary for normalization: instead of repeating album names in the track table,
-- we’re moving them to a separate album table.
INSERT INTO album(title)
SELECT DISTINCT
  album
FROM
  track;

-- Here, we are updating the track table to set the album_id for each track.
-- The album_id is retrieved by matching the album title in the album table with the corresponding album title in track.
-- This links each track to an album by its ID instead of by name, further normalizing the data.
UPDATE
  track
SET
  album_id =(
    SELECT
      album.id
    FROM
      album
    WHERE
      album.title = track.album);

-- This inserts unique pairs of track titles and artist names into the tracktoartist table.
-- The tracktoartist table acts as a bridge between tracks and artists,
-- allowing for a many-to-many relationship (e.g., multiple artists per track or the same artist on multiple tracks).
INSERT INTO tracktoartist(track, artist)
SELECT DISTINCT
  title AS track,
  artist
FROM
  track;

-- This extracts unique artist names from the track table and inserts them into the artist table,
-- normalizing the data by creating a separate list of artists.
INSERT INTO artist(name)
SELECT DISTINCT
  artist
FROM
  track;

-- Here, the track_id in tracktoartist is set by matching the track column in tracktoartist with the title in track.
-- This allows us to link each tracktoartist record to a specific track by its ID,
-- which is more efficient and normalized than using the track title.
UPDATE
  tracktoartist
SET
  track_id =(
    SELECT
      t.id
    FROM
      track t
    WHERE
      t.title = tracktoartist.track);

-- Similarly, this step sets the artist_id in tracktoartist by matching the artist name in tracktoartist with the name in artist.
-- This links each tracktoartist record to a specific artist by ID, again achieving better data normalization.
UPDATE
  tracktoartist
SET
  artist_id =(
    SELECT
      a.id
    FROM
      artist a
    WHERE
      a.name = tracktoartist.artist);

-- We are now done with these text fields
ALTER TABLE track
  DROP COLUMN album;

ALTER TABLE track
  DROP COLUMN track;

ALTER TABLE tracktoartist
  DROP COLUMN track;

ALTER TABLE tracktoartist
  DROP COLUMN artist;

SELECT
  track.title,
  album.title,
  artist.name
FROM
  track
  JOIN album ON track.album_id = album.id
  JOIN tracktoartist ON track.id = tracktoartist.track_id
  JOIN artist ON tracktoartist.artist_id = artist.id
ORDER BY
  track.title
LIMIT 3;

