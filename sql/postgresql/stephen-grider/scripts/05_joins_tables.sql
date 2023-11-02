SELECT
  contents,
  username
FROM
  comments
  JOIN users ON users.id = comments.user_id;

-- ==========================
-- Missing Data in Joins
-- ==========================
SELECT
  url,
  username
FROM
  photos
  JOIN users ON users.id = photos.user_id;

INSERT INTO
  photos (url, user_id)
VALUES
  ('https://banner.jpg', NULL);

-- ==========================
-- Inner Join
-- ==========================
SELECT
  url,
  username
FROM
  photos
  JOIN users ON users.id = photos.user_id;

-- ==========================
-- Left Outer Join
-- ==========================
SELECT
  url,
  username
FROM
  photos
  LEFT JOIN users ON users.id = photos.user_id;

-- ==========================
-- Right Outer Join
-- ==========================
SELECT
  url,
  username
FROM
  photos
  RIGHT JOIN users ON users.id = photos.user_id;

-- ==========================
-- Full Join
-- ==========================
SELECT
  url,
  username
FROM
  photos
  FULL JOIN users ON users.id = photos.user_id;

SELECT
  title,
  name
FROM
  authors
  LEFT JOIN books ON authors.id = books.author_id;

-- ==========================
-- Three Way Join
-- ==========================
/* 
The result of this query will be a list of rows with the username, photo URL, and comment content for each comment that is linked to both a photo and a user, where the user is the same for the photo and the comment.

This three-way join effectively filters the data so that only comments on photos by users who have a corresponding user entry (and presumably are the ones who posted both the comment and the photo) will be selected. It's a way to correlate data across three different tables, ensuring consistency across related records.
 */
SELECT
  username,
  url,
  contents
FROM
  comments
  JOIN photos ON photos.id = comments.photo_id
  JOIN users ON users.id = comments.user_id
  AND users.id = photos.user_id;

/* 
Write a query that will return the title of each book, along with the name of the author, and the rating of a review.  Only show rows where the author of the book is also the author of the review.
 */
-- Option 1
SELECT
  title,
  name,
  rating
FROM
  reviews
  JOIN books ON books.id = reviews.book_id
  JOIN authors ON authors.id = books.author_id
  AND authors.id = reviews.reviewer_id;

-- Option 2
SELECT
  b.title,
  a.name,
  r.rating
FROM
  books b
  JOIN authors a ON a.id = b.author_id -- join books with authors on author_id
  JOIN reviews r ON r.book_id = b.id -- join reviews with books on book_id
WHERE
  -- filter condition where the book's author is the reviewer
  r.reviewer_id = b.author_id;