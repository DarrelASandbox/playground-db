/* eslint-disable camelcase */

exports.shorthands = undefined;

exports.up = (pgm) =>
  pgm.sql(`
    CREATE TABLE users (
      id SERIAL PRIMARY KEY,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
      bio VARCHAR(400),
      username VARCHAR(30) NOT NULL
    );

    INSERT INTO
      users (bio, username)
    VALUES
      ('This is my bio', 'Alyson14'),
      ('This is about me', 'Gia67');
`);

exports.down = (pgm) => pgm.sql(`DROP TABLE users;`);
