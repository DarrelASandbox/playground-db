- [About The Project](#about-the-project)
- [Module 1](#module-1)
  - [`TIMESTAMPTZ`](#timestamptz)
  - [Subqueries](#subqueries)
  - [ACID](#acid)
    - [Atomicity](#atomicity)
    - [Consistency](#consistency)
    - [Isolation](#isolation)
    - [Durability](#durability)
  - [Stored Procedures](#stored-procedures)

# About The Project

- [Intermediate PostgreSQL](https://www.coursera.org/learn/intermediate-postgresql)

# Module 1

## `TIMESTAMPTZ`

- Store time stamps with timezone
- Prefer UTC for stored time stamps
- Convert to local time zone when retrieving

## Subqueries

- **Subqueries**: A query within a query
  - Can use a value or set of values in a query that are computed by another query
- DB admins might avoid subqueries because they can sometimes lead to performance issues, depending on how the database engine handles them and the complexity of the query. Here are a few common reasons DB admins might have a preference for alternatives:
  - **Performance Impact**: Subqueries, especially correlated ones (where the inner query depends on values from the outer query), can be slow. Each time the outer query processes a row, it may need to re-run the subquery, which can quickly add up in resource consumption.
  - **Optimization Difficulty**: Some databases struggle to optimize complex subqueries effectively. Even with indexing, certain types of subqueries can hinder the query planner’s ability to create an efficient execution plan.
  - **Readability and Maintainability**: Queries with deeply nested subqueries can be hard to read, debug, and maintain. Joins and common table expressions (CTEs) are often easier to interpret, especially in complex queries.
  - **Locking and Concurrency**: In cases where the subquery involves large data sets or tables, the query might hold locks on rows for extended periods, impacting concurrency and causing delays for other queries.
  - **Index Usage**: Joins often allow for better use of indexes, especially when tables are properly indexed. Subqueries don’t always leverage indexes effectively, which can impact query speed and efficiency.
- Some of these concerns depend on the specific database being used, as some engines handle subqueries more efficiently than others.

## ACID

ACID is a set of properties that ensures reliable processing of database transactions, standing for Atomicity, Consistency, Isolation, and Durability. PostgreSQL, as an ACID-compliant relational database, strictly adheres to these properties to ensure data integrity and reliability, even in the event of failures or concurrency issues.

### Atomicity

- **Definition**: Transactions are all-or-nothing. If any part of a transaction fails, the entire transaction is rolled back, leaving the database unchanged.
- PostgreSQL Implementation: PostgreSQL uses transactions (with BEGIN, COMMIT, and ROLLBACK statements) to manage atomicity. Any failure within a transaction leads to a rollback of all changes made within it, ensuring the database remains in its previous stable state.

### Consistency

- **Definition**: Transactions must bring the database from one valid state to another, maintaining all predefined rules, such as constraints (e.g., foreign keys, uniqueness).
- PostgreSQL Implementation: PostgreSQL enforces constraints and referential integrity to maintain consistency. It checks all constraints before committing any changes, ensuring that only data that meets the database’s rules is stored.

### Isolation

- **Definition**: Transactions are isolated from each other, so concurrently executing transactions do not interfere in a way that violates database integrity.
- PostgreSQL Implementation: PostgreSQL provides multiple isolation levels, including Read Committed (default), Repeatable Read, and Serializable. Each level determines the extent to which transactions are isolated from each other, with Serializable offering the highest isolation by ensuring transactions execute as though they were sequential.

### Durability

- **Definition**: Once a transaction is committed, its changes are permanent, even in the case of a system crash.
- PostgreSQL Implementation: PostgreSQL achieves durability primarily through its Write-Ahead Logging (WAL) mechanism. Before any data changes are applied to the main data files, they are first recorded in the WAL. This allows PostgreSQL to recover from crashes by replaying the WAL log entries, ensuring that committed transactions persist.

## Stored Procedures

Stored procedures can be useful in database management, but they come with several disadvantages, especially in larger or more complex systems:

1. **Limited Debugging and Testing Tools**: Compared to traditional application code, stored procedures have limited debugging tools. Debugging SQL logic can be cumbersome and complex, especially in large procedures with multiple steps.
2. **Maintenance Complexity**: Stored procedures are often harder to maintain than application code. Modifying a procedure requires database access, which can lead to complications if multiple procedures are interdependent. This can also result in tightly coupled business logic that’s difficult to track and update.
3. **Scalability Issues**: As stored procedures run on the database server, they can put a significant load on it, potentially impacting performance. This can be problematic in systems requiring high scalability, as offloading logic to application servers is often more efficient.
4. **Lack of Version Control**: Unlike application code, it’s difficult to implement version control for stored procedures. This can make it challenging to track changes or roll back to a previous version if issues arise.
5. **Vendor Lock-In**: Stored procedures are often written in proprietary languages (e.g., PL/SQL for Oracle, T-SQL for SQL Server), which may limit portability across different database systems. This can lead to vendor lock-in, making it harder to migrate to a different database platform.
6. **Complex Testing and Deployment**: Integrating stored procedures into CI/CD pipelines is less straightforward than with application code. This adds complexity to automated testing and deployment workflows, which are increasingly important in modern development practices.
7. **Security Risks**: Stored procedures can introduce security risks if not carefully managed, especially if they include dynamic SQL, which can expose the system to SQL injection attacks.
8. **Reduced Readability**: Stored procedures can make codebases more complex, as logic is split between the application and the database. This can be difficult for developers to follow and can complicate onboarding for new team members.
9. **Difficult to Scale Horizontally**: Unlike application servers, databases are harder to scale horizontally. Placing extensive business logic in stored procedures may restrict the system’s ability to distribute the load effectively across multiple database instances.

While stored procedures can provide performance benefits for certain tasks, these drawbacks often make alternative approaches, like using an ORM or placing business logic in application code, more appealing in many cases.
