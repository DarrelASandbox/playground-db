const db = require('../config/db');

class Post {
  constructor(title, body) {
    this.title = title;
    this.body = body;
  }

  async save() {
    let sqlQuery = `
    INSERT INTO
      posts(title, body)
    VALUES
      ('${this.title}', '${this.body}')
    `;

    return db.execute(sqlQuery);
  }

  static findAll() {
    let sqlQuery = 'SELECT * FROM posts;';
    return db.execute(sqlQuery);
  }

  static findById(id) {
    let sqlQuery = `SELECT * FROM posts WHERE post_id = ${id};`;
    return db.execute(sqlQuery);
  }
}

module.exports = Post;
