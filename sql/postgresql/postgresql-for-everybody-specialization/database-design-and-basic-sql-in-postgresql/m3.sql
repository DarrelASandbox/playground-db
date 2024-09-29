CREATE DATABASE music
WITH
  OWNER 'pg4e' ENCODING 'UTF8';

CREATE TABLE
  artist (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY (id)
  );

CREATE TABLE
  album (
    id SERIAL,
    title VARCHAR(128) UNIQUE,
    artist_id INTEGER REFERENCES artist (id) ON DELETE CASCADE,
    PRIMARY KEY (id)
  );

CREATE TABLE
  genre (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY (id)
  );

CREATE TABLE
  track (
    id SERIAL,
    title VARCHAR(128),
    len INTEGER,
    rating INTEGER,
    count INTEGER,
    album_id INTEGER REFERENCES album (id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES genre (id) ON DELETE CASCADE,
    UNIQUE (title, album_id),
    PRIMARY KEY (id)
  );

INSERT INTO
  artist (name)
VALUES
  ('Led Zeppelin'),
  ('AC/DC');

INSERT INTO
  album (title, artist_id)
VALUES
  ('Who Made Who', 2),
  ('IV', 1);

INSERT INTO
  genre (name)
VALUES
  ('Rock'),
  ('Metal');

INSERT INTO
  track (title, rating, len, count, album_id, genre_id)
VALUES
  ('Black Dog', 5, 297, 0, 2, 1),
  ('Stairway', 5, 482, 0, 2, 1),
  ('About to Rock', 5, 313, 0, 1, 2),
  ('Who Made Who', 5, 207, 0, 1, 2);

-- Defaults to INNER JOIN
SELECT
  album.title,
  artist.name
FROM
  album
  JOIN artist ON album.artist_id = artist.id;

-- INNER JOIN
SELECT
  album.title,
  album.artist_id,
  artist.id,
  artist.name
FROM
  album
  INNER JOIN artist ON album.artist_id = artist.id;

-- CROSS JOIN
SELECT
  track.title,
  track.genre_id,
  genre.id,
  genre.name
FROM
  track
  CROSS JOIN genre;

SELECT
  *
FROM
  track;

DELETE FROM genre
WHERE
  name = 'Metal';

-- Default/ RESTRICT - Don't allow changes that break the constraint
-- CASCADE - Adjust child rows by removing or updating to maintain consistency
-- SET NULL - Set the foreign key columns in the child rows to null
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
CREATE TABLE
  make (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY (id)
  );

CREATE TABLE
  model (
    id SERIAL,
    name VARCHAR(128),
    make_id INTEGER REFERENCES make (id) ON DELETE CASCADE,
    PRIMARY KEY (id)
  );

INSERT INTO
  make (name)
VALUES
  ('Ferrari'),
  ('Mercedes-Benz');

INSERT INTO
  model (name, make_id)
VALUES
  ('F12', 1),
  ('F12 Berlinetta', 1),
  ('F12 tdf', 1),
  ('SL400', 2),
  ('SL450', 2);

SELECT
  make.name,
  model.name
FROM
  model
  JOIN make ON model.make_id = make.id
ORDER BY
  make.name
LIMIT
  5;