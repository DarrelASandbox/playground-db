CREATE SCHEMA IF NOT EXISTS blog_app;

USE blog_app;

CREATE TABLE IF NOT EXISTS posts (
  post_id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  body TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE INDEX (post_id),
  PRIMARY KEY (post_id)
);

INSERT INTO
  posts(title, body)
VALUES
("1st Post", "Body of first post!"),
  ("2nd Post", "Body of second post!"),
  ("3rd Post", "Body of third post!"),
  ("4th Post", "Body of fourth post!"),
  ("5th Post", "Body of fifth post!");

SELECT
  *
FROM
  posts;