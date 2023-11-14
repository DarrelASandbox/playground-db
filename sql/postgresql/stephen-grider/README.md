- [About The Project](#about-the-project)
- [Introduction](#introduction)
- [Database Design](#database-design)
- [Joins \& Aggregations](#joins--aggregations)
- [Unions \& Intersections with Sets](#unions--intersections-with-sets)
- [Assembling Queries with SubQueries](#assembling-queries-with-subqueries)
- [PGAdmin](#pgadmin)
- [PostgreSQL](#postgresql)
  - [Validation](#validation)
  - [Where does Postgres store data?](#where-does-postgres-store-data)
- [Instagram](#instagram)
  - [Likes](#likes)
  - [Tags](#tags)
  - [Posts](#posts)
  - [Seed Database](#seed-database)

&nbsp;

# About The Project

- SQL and PostgreSQL: The Complete Developer's Guide
- Become an expert with SQL and PostgreSQL! Store and fetch data, tune queries, and design efficient database structures!
- [Stephen Grider](https://github.com/StephenGrider)
- [pg-sql](https://pg-sql.com/)

&nbsp;

# Introduction

- **Challenges of PostgreSQL**
  - Writing efficient queries to retrieve information
  - Designing the schema, or structure, of the database
  - Understanding when to use advanced features
  - Managing the database in a production environment
    - Backup
    - Scaling
- **Database Design Process**
  - What kind of thing are we storing?
  - What properties does this thing have?
  - What type of data does each of those properties contain?
- **Table**: Collection of records
- **Columns**: Each column records one property about a thing
- **Rows**
- SQL can transform data before we retrieve them from a table
- **Relationships**
  - One-to-One
  - Many-to-Many
- **Primary Key**: Uniquely identifies this record in this table
- **Foreign Key**: Identifies a record (usually in another table) that this row is associated with

|                      Primary Keys                      |                        Foreign Keys                        |
| :----------------------------------------------------: | :--------------------------------------------------------: |
|      Each row in every table has one primary key       |    Rows only have this if they belong to another record    |
| No other row in the same table can have the same value | Many rows in the same table can have the same foreign keys |
|              99% of the time called 'id'               |    Name varies, usually called something like 'xyz_id'     |
|              Either an integer or a UUID               |   Exactly equal to the primary key of the referenced row   |
|                   Will never change                    |          Will change if the relationship changes           |

&nbsp;

# Database Design

- **Database For a Photo-Sharing App**
  - users
  - photos
  - comments
  - likes
- **What Tables Should We Make?**
  - Common features (like authentication, comments, etc) are frequently built with conventional table names and columns
  - What type of resources exist in your app? Create aa separate table for each of these features
  - Features that seem to indicate a relationship or ownership between two types of resources need to be reflected in our table design

&nbsp;

# Joins & Aggregations

- **The more tables we have, the more interesting questions we can answer**
  - Find all the comments for the photo with ID = 3, along with the username of the comment author
  - Find the **average number of comments** per photo
  - Find the photo with the **most comments** attached to it
  - Find the photo with ID = 10 and get the **number of comments** attached to it
  - Find the user with the most activity (most comments + most photos)
  - Calculate the **average number of characters** per comment
- **Joins**:
  - Produces values by merging together rows from different related tables
  - Use a join most times that you're asked to find data that involves multiple resources
- **Aggregation**:
  - Looks at many rows and calculates a single value
  - Words like **'most'**, **'average'**, **'least'** are a sign that you need to use an aggregation

&nbsp;

# Unions & Intersections with Sets

- **`UNION`** - Join together the results of two queries. Remove duplicates
- **`UNION ALL`** - Join together results of two queries
- **`INTERSECT`** - Find the rows common in the results of two queries. Remove duplicates
- **`INTERSECT ALL`** - Find the rows common in the results of two queries
- **`EXCEPT`** - Find the rows that are present in first query but not second query. Remove duplicates
- **`EXCEPT ALL`** - Find the rows that are present in first query but not second query

&nbsp;

# Assembling Queries with SubQueries

![subqueries_source](diagrams/subqueries_source.png)

&nbsp;

![subqueries_operators](diagrams/subqueries_operators.png)

&nbsp;

# PGAdmin

- Tool to manage and inspect a Postgres database
- Can connect to local or remote databases
- Can view/change just about anything in PG
- A PG Server can contain multiple databases
- All data for a single app lives in a single DB
- Having multiple DB's is more about working with more than one app on your machine

&nbsp;

# PostgreSQL

- [Data Types](https://www.postgresql.org/docs/current/datatype.html)
- [Time Zones](https://www.postgresql.org/docs/current/datatype-datetime.html#DATATYPE-TIMEZONES)

| Data to Store                                                                       | Condition                                                                           | Data Type        |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ---------------- |
| 'id' column of any table                                                            | -                                                                                   | serial           |
| Need to store a number without a decimal                                            | -                                                                                   | integer          |
| Bank balance, grams of gold, scientific calculations                                | Need to store a number with a decimal and this data needs to be very accurate       | numeric          |
| Kilograms of trash in a landfill, liters of water in a lake, air pressure in a tire | Need to store a number with a decimal and the decimal doesn't make a big difference | double precision |

## Validation

- Row-Level Validation
- Multi-Column Uniqueness
- Checks Over Multiple Columns
- Validation at web server or database?

|                    Web Server                     |                               Database                               |
| :-----------------------------------------------: | :------------------------------------------------------------------: |
|     Easier to express more complex validation     | Validation still applied even if you connect with a different client |
|     Far easier to apply new validation rules      |             Guaranteed that validation is always applied             |
| Many libraries to handle validation automatically | Can only apply new validation rules if all existing rows satisfy it  |

## Where does Postgres store data?

- [Database Page Layout](https://www.postgresql.org/docs/current/storage-page-layout.html)

|       Term        |                                                   Description                                                    |
| :---------------: | :--------------------------------------------------------------------------------------------------------------: |
| Heap or Heap File |                                 File that contains all data (rows) of our table                                  |
|   Tuple or Item   |                                          Individual row from the table                                           |
|   Block or Page   | The heap file is divided into many different 'blocks' or 'pages'.</br>Each page/block stores some number of rows |

![psql_heaps_blocks_tuples](diagrams/psql_heaps_blocks_tuples.png)

&nbsp;

![psql_block](diagrams/psql_block.png)

&nbsp;

![psql_block_data_layout](diagrams/psql_block_data_layout.png)

&nbsp;

# Instagram

## Likes

- **Rules**
  - Each user can like a specific post a single time
  - A user should be able to 'unlike' a post
  - Need to be able to figure out how many users like a post
  - Need to be able to list which users like a post
  - Something besides a post might need to be liked (comments, maybe?)
  - We might want to think about 'dislikes' or other kinds of reactions
- **Do not add a 'likes' Column to Posts**
  - No way to make sure a user likes a post only once
  - No way to make sure a user can only 'unlike' a post they have liked
  - No way to figure out which users like a particular post
  - No way to remove a like if a user gets deleted

![instagram_polymorphic_association](diagrams/instagram_polymorphic_association.png)

- **Polymorphic Association**
  - A like can be a 'post like' or a 'comment like'
  - Not recommended, but you'll still see it in use
  - Requires your app to figure out the meaning of each like
  - Can't use foreign key columns - `liked_id` is a plain integer

![instagram_polymorphic_association_2](diagrams/instagram_polymorphic_association_2.png)

- **Polymorphic Association alternative implementation**
  - Each possible type of relation gets its own FK column
  - We'd still want to make sure either `post_id` or `comment_id` is not `NULL`

```sql
Add CHECK of (
  COALESCE((post_id)::BOOLEAN::INTEGER, 0) + COALESCE((comment_id)::BOOLEAN::INTEGER, 0)
) = 1
```

- **Using Additional Tables**
  - Each type of like gets its own table
  - Still want to write queries that will count up all likes? You can use a Union or a View

## Tags

![instagram_tag_solution_1](diagrams/instagram_tag_solution_1.png)

&nbsp;

![instagram_tag_solution_2](diagrams/instagram_tag_solution_2.png)

- Do you expect to query for `caption_tags` and `photo_tags` at different rates?
- Will the meaning of a `photo_tags` change at some point?

## Posts

- Number of posts and followers can be calculated by running a query on data that already exists in our database
- We call this **derived data** which we generally don't want to store derived data

&nbsp;

---

&nbsp;

1. `UNIQUE(user_id, post_id), UNIQUE(user_id, comment_id)`:

   - This creates two separate unique constraints.
   - The first one ensures that the combination of `user_id` and `post_id` is unique across the table. In other words, a user cannot have more than one entry with the same `post_id`.
   - The second one ensures that the combination of `user_id` and `comment_id` is unique. This means a user cannot have more than one entry with the same `comment_id`.
   - These constraints are useful if you want to prevent a user from liking/commenting on a post or a comment more than once, but they allow a user to associate with the same post through different comments or vice versa.

2. `UNIQUE(user_id, post_id, comment_id)`:
   - This creates a single unique constraint on the combination of all three fields.
   - This means the entire combination of `user_id`, `post_id`, and `comment_id` must be unique in each row. A user can't have multiple entries with the same combination of post and comment IDs.
   - This constraint is stricter. It's useful if you want each row to represent a unique action of a user on a specific comment of a specific post. For instance, this could be used in a scenario where users are reacting to specific comments on specific posts, and you want to ensure that each reaction is unique.

The choice between these depends on your specific use case:

- If you want to allow a user to interact with a post multiple times through different comments (or vice versa), use the first option.
- If you want to ensure that a user's interaction is unique for each specific comment on a specific post, use the second option.

It's important to align this decision with the logical structure of your application and how you intend users to interact with posts and comments.

&nbsp;

---

&nbsp;

## Seed Database

**Important Notes**:

- Ensure that the database (`instagram`) exists before you run this command.
- You might need to use additional flags like `-U` for specifying the username if you're not operating as the default user.
- It's crucial to understand the implications of disabling triggers and not restoring ownership, especially in a production environment, as these can affect database functionality and security.

```sh
# `-d instagram`: Specifies the database to restore to.
# `-a` or `--data-only`: Restores only the data.
# `-x` or `--no-owner`: Skips restoring ownership.
# `--disable-triggers`: Disables triggers during the restore. (Remember, you need superuser privileges for this.)
# `-1` - Execute the restore as a single transaction (this is useful for ensuring atomicity).
# `-v` or `--verbose`: Enables verbose mode.
pg_restore -d instagram -a -x --disable-triggers -1 -v sql/postgresql/stephen-grider/scripts/db/04_instagram_seed.sql
```

&nbsp;
