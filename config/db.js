require('dotenv').config();
const mysql = require('mysql2');

const pool = mysql.createPool({
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  database: process.env.MYSQL_NAME,
  password: process.env.MYSQL_PASSWORD,
});

module.exports = pool.promise(); // Promise Wrapper
