require('dotenv').config();

const express = require('express');
const pg = require('pg');

const pool = new pg.Pool({
  host: 'localhost',
  port: 5432,
  database: 'insta',
  user: process.env.PGDB_USER,
  password: process.env.PGDB_PASSWORD,
});

const app = express();
app.use(express.urlencoded({ extended: true }));

app.get('/posts', async (req, res) => {
  const { rows } = await pool.query('SELECT * FROM posts;');
  res.send(`
    <table>
      <thead>
        <tr>
          <th>id</th>
          <th>lng</th>
          <th>lat</th>
        </tr>
      </thead>

      <tbody>
        ${rows
          .map(
            (row) => `
          <tr>
            <td>${row.id}</td>
            <td>${row.lng}</td>
            <td>${row.lat}</td>
          </tr>
        `
          )
          .join('')}
      </tbody>
    </table>

    <form method="POST">
      <h3>Create Post</h3>
      <div>
        <label></label>
        <input name="lng"/>
      </div>
      <div>
        <label></label>
        <input name="lat"/>
      </div>
      <button type="submit">Create</button>
    </form>
  `);
});

app.post('/posts', async (req, res) => {
  const { lat, lng } = req.body;
  const queryText = 'INSERT INTO posts (lat, lng, loc) VALUES ($1, $2, $3)';
  await pool.query(queryText, [lat, lng, `(${lng}, ${lat})`]);
  res.redirect('/posts');
});

app.listen(3005, () => console.log('Listening on port 3005'));
