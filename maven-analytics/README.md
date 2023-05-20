## About the Project

- MySQL Database Administration: Beginner SQL Database Design
- Learn Database Design with MySQL Workbench. SQL DBA for Beginners: A Relational Database Management System Introduction.
- Maven Analytics

&nbsp;

---

&nbsp;

## Basics

|             Course             |                                                    Outline                                                    |
| :----------------------------: | :-----------------------------------------------------------------------------------------------------------: |
|      Introduction & Setup      | Discuss relational databases, download MySQL Community Server and Workbench, and create the project databases |
|   Creating Schemas & Tables    |      Create and delete schemas, tables, and columns using the Workbench Editor, and by running SQL code       |
| Inserting, Updating & Deleting |     Insert data into tables, and update or delete specific records based on logical criteria you specify      |
|        Database Design         |     Learn about table relationships, primary and foreign keys, and 4 how to properly normalize a database     |
|     Advanced DBA Concepts      |  Create stored procedures, triggers, and indexes, and learn how to implement unique and non-NULL constraints  |
|  Managing Users & Permissions  |       Grant access to additional users and prescribe what they can 6 and cannot do within the database        |

&nbsp;

---

&nbsp;

- <b>Scenario: </b>You have just been hired by a small database consulting shop. You will be working on projects for various clients to help them get their databases built and optimized for business
- <b>Brief: </b>As a member of the consulting team, you will be asked to perform database services for various clients. Sometimes you will work with existing databases and tables to make small improvements, and other times you will need to set up a database for clients from the ground up
- <b>Objective: </b>
  - Create databases and tables your clients will need to run their businesses
  - Use your knowledge of database best practices to implement and optimize database design principles
  - Update records, create indexes, triggers, and stored procedures, and manage users and permissions
- Relational databases consist of data stored in multiple tables
- Relational database management systems (RDBMS) serve as an interface to access and manage relational databases, using SQL
- RDBMS administrators can grant access to users and set specific roles and permissions

&nbsp;

---

&nbsp;

> <b>Bruna: </b>Safe Mode

> <b>John: </b>It's up to you whether you use safe mode or not. I would call this a matter of your personal comfort.
>
> 1. Do what you did here. Disable safe mode.
>
> 2. Include the primary key in a WHERE condition. What if you're updating all records? No problem! You can do the following...
>
> WHERE employee_id > 0
>
> ...this would still perform the action on all records (the WHERE clause doesnt filter any out), but it technically incorporates the PK so safe mode is still happy.
>
> You can leave safe mode on or disable it like you did. Some people like having that error warning as an extra reminder to check their work and make sure they aren't doing something dangerous with the UPDATE. Others think this is a silly extra step.
>
> Totally up to you.

&nbsp;

---

&nbsp;

- <b>Truncate Table: </b>
  - If we want to remove all records from a table but preserve the table structure, we can do that using TRUNCATE TABLE
  - When we use TRUNCATE TABLE, the data is removed but the column names, data types, column order, and any constraints placed on the table are all preserved
  - TRUNCATE TABLE is very similar to using DELETE without a WHERE clause but you cannot ROLLBACK

|         Languages          |     |                                                                                |
| :------------------------: | :-: | :----------------------------------------------------------------------------: |
|  DATA DEFINITION LANGUAGE  | DDL | Used to query data (often considered part of DML) Examples: SELECT, SHOW, HELP |
| DATA MANIPULATION LANGUAGE | DML |  Used to add, modify, or delete data records Examples: INSERT, UPDATE, DELETE  |
|    DATA QUERY LANGUAGE     | DQL | Used to query data (often considered part of DML) Examples: SELECT, SHOW, HELP |
|   DATA CONTROL LANGUAGE    | DCL |          Used to grant and revoke permissions Examples: GRANT, REVOKE          |
| DATA TRANSACTION LANGUAGE  | DTL |   Used to manage transactions Examples: START TRANSACTION, COMMIT, ROLLBACK    |

&nbsp;

---

&nbsp;

## Database Design

- <b>Cardinality</b> refers to the uniqueness of values in a column (or attribute) of a table and is commonly used to describe how two tables relate (one-to-one, one-to-many, or many-to-many).
- <b>Primary keys</b> are unique
  - They cannot repeat, so there is only one instance of each primary key value in a column
- <b>Foreign keys</b> are non-unique
  - They can repeat, so there may be many instances of each foreign key value in a column
- We can create a <b>one-to-many</b> relationship by connecting a <b>foreign key</b> in one table to
  a <b>primary key</b> in another

![mavenfuzzyfactorymini-schema](./diagrams/mavenfuzzyfactorymini-schema.png)

- <b>Normalization</b> is the process of structuring the tables and columns in a relational database to <b>minimize redundancy</b> and <b>preserve data integrity</b>. - Benefits of normalization include:
  - <b>Eliminating duplicate data</b> (this makes storage and query processing more efficient)
  - <b>Reducing errors and anomalies</b> (restrictions around data structure help to prevent human errors)
- <b>Enhanced Entity Relationship (EER) Models</b>
  - Which tables are in the database
  - Which columns exist in each table
  - The data types of the various columns
  - Primary and foreign keys within tables
  - Relationship cardinality between tables
  - Constraints on columns (i.e. Non-NULL)
- [What do the mysql workbench column icons mean](https://stackoverflow.com/questions/10778561/what-do-the-mysql-workbench-column-icons-mean)

&nbsp;

---

&nbsp;

## Mid Course Project

- <b>Scenario: </b>A new client, the owner of the Maven Movies DVD rental business, has reached out to you for help restructuring their non-normalized database.
- <b>Objective: </b>Use Your MySQL Database Administration skills to: Design a better set of tables to store the data in the existing schema. Explain to the owner why the current system is not optimized for scale, and how you propose to improve it. Then, create a new schema with your ideal specifications and populate it with data.
- <b>Questions: </b>Take a look at the mavenmoviesmini schema.
  - What do you notice about it?
  - How many tables are there?
  - What does the data represent?
  - What do you think about the current schema?
  - If you wanted to break out the data from the inventory_non_normalized table into multiple tables, how many tables do you think would be ideal? What would you name those tables?
  - Based on your answer from question #2, create a new schema with the tables you think will best serve this data set. You can use SQL code or Workbench’s UI tools (whichever you feel more comfortable with).
  - Next, use the data from the original schema to populate the tables in your newly optimized schema
  - Make sure your new tables have the proper primary keys defined and that applicable foreign keys are added. Add any constraints you think should apply to the data as well (unique, non-NULL, etc.)
  - Finally, after doing all of this technical work, write a brief summary of what you have done, in a way that your non-technical client can understand. Communicate what you did, and why your new schema design is better.

&nbsp;

---

&nbsp;

## Basic Plus

- Indexes
- Constraint
  - Unique
  - Non-Null
- Stored Procedures
- Triggers

&nbsp;

---

&nbsp;

## Server Management

- Administration tab -> Management -> Users and Privileges

&nbsp;

---

&nbsp;

## Final Course Project

- <b>Scenario: </b>A new client, Bubs Glover, the owner of Bubs’ Bigtime Baby Booties, has reached out to you for help building his business a database from the ground up.
- <b>Objective: </b>Use Your MySQL Database Administration skills to: Design a database from scratch, which will capture information about Bubs’ customers, the purchases they make, his products, and his employees.

- <b>Questions: </b>Bubs wants you to track information on his customers (first name, last name, email), his employees (first name, last name, start date, position held), his products, and the purchases customers make (which customer, when it was purchased, for how much money). Think about how many tables you should create.
  - Which data goes in which tables?
  - How should the tables relate to one another?
  - Given the database design you came up with, use Workbench to create an EER diagram of the database. Include things like primary keys and foreign keys, and anything else you think you should have in the tables. Make sure to use reasonable data types for each column.
  - Create a schema called bubsbooties. Within that schema, create the tables that you have diagramed out. Make sure they relate to each other, and that they have the same reasonable data types you selected previously.
  - Add any constraints you think your tables’ columns should have. Think through which columns need to be unique, which ones are allowed to have NULL values, etc.
  - Insert at least 3 records of data into each table. The exact values do not matter, so feel free to make them up. Just make sure that the data you insert makes sense, and that the tables tie together.
  - Create two users and give them access to the database. The first user, TuckerReilly, will be the DBA, and should get full database administrator privileges. The second user, EllaBrody, is an Analyst, and only needs read access.

&nbsp;

---

&nbsp;
