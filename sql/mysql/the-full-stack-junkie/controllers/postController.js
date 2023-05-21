const Post = require('../models/postModel');
const HttpError = require('../models/http-error');

const getAllPosts = async (req, res, next) => {
  try {
    const [posts, _] = await Post.findAll();
    res.send({ totalPosts: posts.length, posts });
  } catch (error) {
    console.log(error);
    return next(new HttpError('Failed to fetch all posts.', 500));
  }
};

const createNewPost = async (req, res, next) => {
  try {
    const { title, body } = req.body;
    const newPost = new Post(title, body);
    const post = await newPost.save();
    const [savedPost, _] = await Post.findById(post[0].insertId);
    res.status(201).send(savedPost[0]);
  } catch (error) {
    console.log(error);
    return next(new HttpError('Failed to create post.', 400));
  }
};

const getPostById = async (req, res, next) => {
  try {
    const [post, _] = await Post.findById(req.params.id);
    res.send(post[0]);
  } catch (error) {
    console.log(error);
    return next(new HttpError('Failed to fetch post by Id.', 400));
  }
};

module.exports = { getAllPosts, createNewPost, getPostById };
