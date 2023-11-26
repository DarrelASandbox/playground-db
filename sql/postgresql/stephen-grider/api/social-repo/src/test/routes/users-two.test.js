require('dotenv').config();

const request = require('supertest');

const buildApp = require('../../app');
const UserRepo = require('../../repos/user-repo');
const pool = require('../../pool');

// Establish a connection to the database for testing purposes.
// This is necessary here as the main connection is established in `index.js`.
beforeAll(() =>
  pool.connect({
    host: 'localhost',
    port: 5432,
    database: 'social-repo-test',
    user: process.env.PGDB_USER,
    password: process.env.PGDB_PASSWORD,
  })
);

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
