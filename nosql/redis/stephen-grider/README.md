## About The Project

- Redis: The Complete Developer's Guide
- Master Redis v7.0 with hands-on exercises. Includes Modules, Scripting, Concurrency, and Streams!
- [Stephen Grider](https://github.com/StephenGrider)

&nbsp;

---

&nbsp;

## Introduction

### Redis

- **Why is Redis fast?**
  - All data is stored in memory
  - Data is organized in simple data structure
  - Redis has a simple feature set
- **Trade-off:** It is more expensive to store in memory

&nbsp;

![memory-vs-hard-drive](diagrams/memory-vs-hard-drive.png)

&nbsp;

![data-structure](diagrams/data-structure.png)

|  Traditional Database Feature Set  | Redis Feature Set |
| :--------------------------------: | :---------------: |
|        Enforced data schema        |   ...Not much!    |
|              Triggers              |                   |
|      Foreign key constraints       |                   |
| Uniqueness of arbitrary properties |                   |
|            SQL Support             |                   |
|        Transaction rollback        |                   |

### Setup

- [redis.com](https://redis.com/)
- [rbook](http://rbook.cloud/)
- Config
  - `Public endpoint`: `Host` and `Port`
  - `Default user password`: `Password`

```sh
SET key value
SET message 'Hi there'
GET message
```

### Commands

- [redis.io - Commands](https://redis.io/commands/)

![commands-data-types](diagrams/commands-data-types.png)

&nbsp;

![commands-strings](diagrams/commands-strings.png)

&nbsp;

![commands-getters-setters](diagrams/commands-getters-setters.png)

&nbsp;

- Why would we ever want to replace part of a string?

&nbsp;

![traditional-db-problem](diagrams/traditional-db-problem.png)

&nbsp;

![encoding](diagrams/encoding.png)

&nbsp;

![encoded-table](diagrams/encoded-table.png)

&nbsp;

![redis-insert](diagrams/redis-insert.png)

&nbsp;

![redis-operations](diagrams/redis-operations.png)

&nbsp;

---

&nbsp;
