CREATE DATABASE instagram;

CREATE TABLE
  users (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    username VARCHAR(30) NOT NULL,
    bio VARCHAR(400),
    avatar VARCHAR(200),
    phone VARCHAR(25),
    email VARCHAR(40),
    password VARCHAR(50),
    status VARCHAR(15),
    CHECK (COALESCE(phone, email) IS NOT NULL),
    CHECK (
      email ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'
    )
  );

CREATE TABLE
  posts (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    url VARCHAR(200) NOT NULL,
    caption VARCHAR(240),
    lat REAL CHECK (
      lat is NULL
      OR (
        lat >= -90
        AND lat <= 90
      )
    ),
    lng REAL CHECK (
      lng is NULL
      OR (
        lng >= -180
        AND lng <= 180
      )
    ),
    CHECK ((lat IS NULL) = (lng IS NULL)),
    user_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE
  );

CREATE TABLE
  comments (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    contents VARCHAR(240) NOT NULL,
    user_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES posts (id) ON DELETE CASCADE
  );

CREATE TABLE
  likes (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    post_id INTEGER REFERENCES posts (id) ON DELETE CASCADE,
    comment_id INTEGER REFERENCES comments (id) ON DELETE CASCADE,
    CHECK (
      COALESCE((post_id)::BOOLEAN::INTEGER, 0) + COALESCE((comment_id)::BOOLEAN::INTEGER, 0) = 1
    ),
    UNIQUE (user_id, post_id),
    UNIQUE (user_id, comment_id)
  );

CREATE TABLE
  photo_tags (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    x INTEGER NOT NULL,
    y INTEGER NOT NULL,
    UNIQUE (user_id, post_id)
  );

CREATE TABLE
  caption_tags (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    UNIQUE (user_id, post_id)
  );

CREATE TABLE
  hashtags (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    title VARCHAR(20) NOT NULL UNIQUE
  );

CREATE TABLE
  hashtags_posts (
    id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    hashtag_id INTEGER NOT NULL REFERENCES hashtags (id) ON DELETE CASCADE,
    UNIQUE (hashtag_id, post_id)
  );

CREATE TABLE
  followers (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    leader_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    follower_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    UNIQUE (leader_id, follower_id)
  );