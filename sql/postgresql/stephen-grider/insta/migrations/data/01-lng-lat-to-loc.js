require('dotenv').config();

const pg = require('pg');

const pool = new pg.Pool({
  host: 'localhost',
  port: 5432,
  database: 'insta',
  user: process.env.PGDB_USER,
  password: process.env.PGDB_PASSWORD,
});

pool
  .query(
    `
  UPDATE posts
  SET loc = POINT(lng, lat)
  WHERE loc IS NULL;
`
  )
  .then(() => {
    console.log('Updated');
    pool.end();
  })
  .catch((err) => console.error(err.message));
