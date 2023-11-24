require('dotenv').config();

const request = require('supertest');

const buildApp = require('../../app');
const UserRepo = require('../../repos/user-repo');
const pool = require('../../pool');

// Establish a connection to the database for testing purposes.
// This is necessary here as the main connection is established in `index.js`.
beforeAll(() => {
  return pool.connect({
    host: 'localhost',
    port: 5432,
    database: 'social-repo',
    user: process.env.PGDB_USER,
    password: process.env.PGDB_PASSWORD,
  });
});

it('create a user', async () => {
  const startingCount = await UserRepo.count();
  expect(startingCount).toEqual(2); // Refer to 1700696465774_add-users-table

  await request(buildApp())
    .post('/users')
    .send({ username: 'testUser', bio: 'testBio' }.expect(200));

  const finishCount = await UserRepo.count();
  expect(finishCount).toEqual(3);
});
