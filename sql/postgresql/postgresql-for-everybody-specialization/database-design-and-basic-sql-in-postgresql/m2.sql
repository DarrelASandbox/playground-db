-- Auto Increment
CREATE TABLE
  automagic (
    id SERIAL,
    name VARCHAR(32) NOT NULL,
    height DOUBLE PRECISION NOT NULL
  );

-- Musical Track Database (CSV)
CREATE TABLE
  track_raw (
    title TEXT,
    artist TEXT,
    album TEXT,
    count INTEGER,
    rating INTEGER,
    len INTEGER
  );