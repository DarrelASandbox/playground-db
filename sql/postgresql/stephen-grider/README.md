- [About The Project](#about-the-project)
- [Introduction](#introduction)
- [Database Design](#database-design)
- [Joins \& Aggregations](#joins--aggregations)

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
