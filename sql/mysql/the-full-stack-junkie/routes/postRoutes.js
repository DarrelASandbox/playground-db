const express = require('express');

const router = express.Router();
const {
  getAllPosts,
  createNewPost,
  getPostById,
} = require('../controllers/postController');

router.route('/').get(getAllPosts).post(createNewPost);
router.route('/:id').get(getPostById);

module.exports = router;
