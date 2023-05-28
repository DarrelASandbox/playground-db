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
- [node-redis](https://github.com/redis/node-redis)

```.env
REDIS_HOST=
REDIS_PORT=
REDIS_PW=
```

![sveltekit-server](00-diagrams/sveltekit-server.png)

&nbsp;

![redis-cache-html](00-diagrams/redis-cache-html.png)

&nbsp;

- **SQL Database Design Methodology**
  - Put the data in tables
  - Figure out how we will query it
- **Redis Design Methodology**
  - Figure out what queries we need to answer
  - Structure data to best answer those queries

&nbsp;

|               Design Considerations               |                                                     |
| :-----------------------------------------------: | :-------------------------------------------------: |
|         What type of data are we storing?         |                       Strings                       |
|  Should we be concerned about the size of data?   |            YES! Only cache certain pages            |
|          Do we need to expire this data?          | Yes, expire after some number of minutes/hours/days |
| What will the key naming policy be for this data? |                     Refer below                     |
|           Any business-logic concerns?            |                        Nope                         |

- **Key Naming**
  - Unique
  - Understandable
  - Use functions to generate your key names so you never make a typo
  - Extremely common practice is to use a ':' to separate different parts of the key
    - users:45
    - items:19
    - users:posts:901
    - posts:jqip25jnm
  - Small twist on common practice - we are going to use a # before unique ID's to make implementing search easier

&nbsp;

![custom-and-static-pages](00-diagrams/custom-and-static-pages.png)

&nbsp;

- **Hashes in Redis**
  - Must be string
  - key value pair
  - Cannot have **nested** key value pair
- `npm run sandbox`

&nbsp;

![commands-hash](00-diagrams/commands-hash.png)

&nbsp;

![redis-hset](00-diagrams/redis-hset.png)

&nbsp;

![redis-hgetall](00-diagrams/redis-hgetall.png)

&nbsp;

&nbsp;

---

&nbsp;
