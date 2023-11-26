require('dotenv').config();

const request = require('supertest');

const buildApp = require('../../app');
const UserRepo = require('../../repos/user-repo');
const pool = require('../../pool');

const { randomBytes } = require('crypto');
const { default: migrate } = require('node-pg-migrate');

// Establish a connection to the database for testing purposes.
// This is necessary here as the main connection is established in `index.js`.
beforeAll(async () => {
  const roleName = 'a' + randomBytes(4).toString('hex');

  await pool.connect({
    host: 'localhost',
    port: 5432,
    database: 'social-repo-test',
    user: process.env.PGDB_USER,
    password: process.env.PGDB_PASSWORD,
  });

  await pool.query(`CREATE ROLE ${roleName} WITH LOGIN PASSWORD '${roleName}'`);
  await pool.query(`CREATE SCHEMA ${roleName} AUTHORIZATION ${roleName}`);

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
});

// Close the database connection after all tests have completed.
// This ensures that Jest can exit cleanly by resolving any pending database connections.
afterAll(() => pool.close());

it('create a user', async () => {
  const startingCount = await UserRepo.count();

  await request(buildApp())
    .post('/users')
    .send({ username: 'testUser', bio: 'testBio' })
    .expect(200);

  const finishCount = await UserRepo.count();
  expect(finishCount - startingCount).toEqual(1);
});
