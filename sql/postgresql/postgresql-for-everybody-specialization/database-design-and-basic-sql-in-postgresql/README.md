# About The Project

- [Database Design and Basic SQL in PostgreSQL](https://www.coursera.org/learn/database-design-postgresql/)

# Terminology

- **Database**: contains one or more tables
- **Relation (or table)**: contains tuples and attributes
- **Tuple (or row)**: a set of fields which generally represent an "object" like a person or a music track
- **Attribute (also column or field)**: one of possibly many elements of data corresponding to the object represented by the row

# CLI

```sh
# '#' sign means super user
psql -U postgres
psql postgres

# List database
\l

# Creating a User
CREATE USER pg4e WITH PASSWORD 'secret';
# Creating a Database
CREATE DATABASE people WITH OWNER 'pg4e';
\q

# Connecting to a Database
psql people pg4e
# Did not find any relations.
\dt

# Create a table
CREATE TABLE users(
  name VARCHAR(128),
  email VARCHAR(128)
);
\dt
\d+ users
```
