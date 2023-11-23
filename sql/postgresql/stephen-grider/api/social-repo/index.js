require('dotenv').config();

const app = require('./src/app.js');
const pool = require('./src/pool.js');

pool
  .connect({
    host: 'localhost',
    port: 5432,
    database: 'social-repo',
    user: process.env.PGDB_USER,
    password: process.env.PGDB_PASSWORD,
  })
  .then(() => app().listen(3005, () => console.log('Listening on port 3005')))
  .catch((err) => console.error(err));
