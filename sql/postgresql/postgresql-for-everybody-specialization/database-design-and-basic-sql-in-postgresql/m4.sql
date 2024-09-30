CREATE DATABASE school
WITH
  OWNER 'pg4e' ENCODING 'UTF8';

CREATE TABLE
  student (
    id SERIAL,
    name VARCHAR(128),
    email VARCHAR(128) UNIQUE,
    PRIMARY KEY (id)
  );

CREATE TABLE
  course (
    id SERIAL,
    title VARCHAR(128) UNIQUE,
    PRIMARY KEY (id)
  );

CREATE TABLE
  member (
    student_id INTEGER REFERENCES student (id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES course (id) ON DELETE CASCADE,
    role INTEGER,
    PRIMARY KEY (student_id, course_id)
  );

INSERT INTO
  student (name, email)
VALUES
  ('Jane', 'jane@tsugi.org'),
  ('Ed', 'ed@tsugi.org'),
  ('Sue', 'sue@tsugi.org');

SELECT
  *
FROM
  student;

INSERT INTO
  course (title)
VALUES
  ('Python'),
  ('SQL'),
  ('PHP');

SELECT
  *
FROM
  course;

INSERT INTO
  member (student_id, course_id, role)
VALUES
  (1, 1, 1),
  (2, 1, 0),
  (3, 1, 0),
  (1, 2, 0),
  (2, 2, 1),
  (2, 3, 1),
  (3, 3, 0);

SELECT
  student.name,
  member.role,
  course.title
FROM
  student
  JOIN member ON member.student_id = student.id
  JOIN course ON member.course_id = course.id
ORDER BY
  course.title,
  member.role DESC,
  student.name;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
CREATE TABLE
  student (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY (id)
  );

DROP TABLE course CASCADE;

CREATE TABLE
  course (
    id SERIAL,
    title VARCHAR(128) UNIQUE,
    PRIMARY KEY (id)
  );

DROP TABLE roster CASCADE;

CREATE TABLE
  roster (
    id SERIAL,
    student_id INTEGER REFERENCES student (id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES course (id) ON DELETE CASCADE,
    role INTEGER,
    UNIQUE (student_id, course_id),
    PRIMARY KEY (id)
  );

INSERT INTO
  student (name)
VALUES
  ('Zubayr'),
  ('Bronagh'),
  ('Cuba'),
  ('Phoebe'),
  ('Sophie'),
  ('Candice'),
  ('Brooke'),
  ('Iqra'),
  ('Milena'),
  ('Uzma'),
  ('Adie'),
  ('Amnah'),
  ('Gus'),
  ('Julie'),
  ('Odhran');

SELECT
  *
FROM
  student;

INSERT INTO
  course (title)
VALUES
  ('si106'),
  ('si110'),
  ('si206');

SELECT
  *
FROM
  course;

INSERT INTO
  roster (student_id, course_id, role)
VALUES
  (1, 1, 1),
  (2, 1, 0),
  (3, 1, 0),
  (4, 1, 0),
  (5, 1, 0),
  (6, 2, 1),
  (7, 2, 0),
  (8, 2, 0),
  (9, 2, 0),
  (10, 2, 0),
  (11, 3, 1),
  (12, 3, 0),
  (13, 3, 0),
  (14, 3, 0),
  (15, 3, 0);

SELECT
  student.name,
  course.title,
  roster.role
FROM
  student
  JOIN roster ON student.id = roster.student_id
  JOIN course ON roster.course_id = course.id
ORDER BY
  course.title,
  roster.role DESC,
  student.name;