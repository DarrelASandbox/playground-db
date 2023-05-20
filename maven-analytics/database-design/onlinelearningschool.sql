USE onlinelearningschool;

SELECT
  *
FROM
  courses;

SELECT
  *
FROM
  course_ratings;

SELECT
  *
FROM
  course_ratings_summaries;

ALTER TABLE
  course_ratings DROP COLUMN course_name;

ALTER TABLE
  course_ratings DROP COLUMN instructor;