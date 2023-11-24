const request = require('supertest');

const buildApp = require('../../app');
const UserRepo = require('../../repos/user-repo');

it('create a user', async () => {
  const startingCount = await UserRepo.count();
  expect(startingCount).toEqual(2); // Refer to 1700696465774_add-users-table

  await request(buildApp())
    .post('/users')
    .send({ username: 'testUser', bio: 'testBio' }.expect(200));

  const finishCount = await UserRepo.count();
  expect(finishCount).toEqual(3);
});
