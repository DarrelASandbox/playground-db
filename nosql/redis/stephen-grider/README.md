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

![memory-vs-hard-drive](00-diagrams/memory-vs-hard-drive.png)

&nbsp;

![data-structure](00-diagrams/data-structure.png)

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

![commands-data-types](00-diagrams/commands-data-types.png)

&nbsp;

![commands-strings](00-diagrams/commands-strings.png)

&nbsp;

![commands-getters-setters](00-diagrams/commands-getters-setters.png)

&nbsp;

- Why would we ever want to replace part of a string?

&nbsp;

![traditional-db-problem](00-diagrams/traditional-db-problem.png)

&nbsp;

![encoding](00-diagrams/encoding.png)

&nbsp;

![encoded-table](00-diagrams/encoded-table.png)

&nbsp;

![redis-insert](00-diagrams/redis-insert.png)

&nbsp;

![redis-operations](00-diagrams/redis-operations.png)

&nbsp;

---

&nbsp;

![commands-numbers](00-diagrams/commands-numbers.png)

&nbsp;

- Why do these commands exist?

&nbsp;

![two-round-trips](00-diagrams/two-round-trips.png)

&nbsp;

![concurrent-updates](00-diagrams/concurrent-updates.png)

&nbsp;

![synchronous-processing](00-diagrams/synchronous-processing.png)

&nbsp;

---

&nbsp;

### 02-rbay

- [redislabs](https://app.redislabs.com/#/)

```.env
REDIS_HOST=
REDIS_PORT=
REDIS_PW=
```

&nbsp;

---

&nbsp;
