const express = require('express');
const UserRepo = require('../repos/user-repo');

const router = express.Router();

router.get('/users', async (req, res) => {
  const users = await UserRepo.find();
  res.send(users);
});

router.get('/users/:id', async (req, res) => {
  const { id } = req.params;
  const user = await UserRepo.findById(id);
  return user ? res.send(user) : res.sendStatus(404);
});

router.post('/users', async (req, res) => {
  const { username, bio } = req.body;
  const user = await UserRepo.insert(username, bio);
  res.send(user);
});

// Need to setup update trigger in psql
// to update `updatedAt`
router.put('/users/:id', async (req, res) => {
  const { id } = req.params;
  const { username, bio } = req.body;
  const user = await UserRepo.update(id, username, bio);
  return user ? res.send(user) : res.sendStatus(404);
});

router.delete('/users/:id', async (req, res) => {
  const { id } = req.params;
  const user = await UserRepo.delete(id);
  return user ? res.send(user) : res.sendStatus(404);
});

module.exports = router;
