require('dotenv').config();

const { randomBytes } = require('crypto');

const { default: migrate } = require('node-pg-migrate');
const format = require('pg-format');
const pool = require('../pool');

DEFAULT_OPS = {
  host: 'localhost',
  port: 5432,
  database: 'social-repo-test',
  user: process.env.PGDB_USER,
  password: process.env.PGDB_PASSWORD,
};

class Context {
  static async build() {
    const roleName = 'a' + randomBytes(4).toString('hex');

    await pool.connect(DEFAULT_OPS);

    await pool.query(
      format('CREATE ROLE %I WITH LOGIN PASSWORD %L;', roleName, roleName)
    );
    await pool.query(format('CREATE SCHEMA %I AUTHORIZATION %I;', roleName, roleName));

    await pool.close();

    // Run our migrations in the new schema
    await migrate({
      schema: roleName,
      direction: 'up',
      log: () => {},
      noLock: true,
      dir: 'migrations',
      databaseUrl: {
        host: 'localhost',
        port: 5432,
        database: 'social-repo-test',
        user: roleName,
        password: roleName,
      },
    });

    await pool.connect({
      host: 'localhost',
      port: 5432,
      database: 'social-repo-test',
      user: roleName,
      password: roleName,
    });

    return new Context(roleName);
  }

  constructor(roleName) {
    this.roleName = roleName;
  }

  // Cleanup
  async close() {
    await pool.close();
    await pool.connect(DEFAULT_OPS);
    await pool.query(format('DROP SCHEMA %I CASCADE;', this.roleName));
    await pool.query(format('DROP ROLE %I;', this.roleName));
    await pool.close();
  }
}

module.exports = Context;
