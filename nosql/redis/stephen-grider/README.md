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

## 02-rbay Part I

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

---

&nbsp;

## Hashes

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

![response-object-or-null](00-diagrams/response-object-or-null.png)

&nbsp;

---

&nbsp;

## 02-rbay Part II

- **Basic Auction Rules**
  - Users create 'items' to sell
  - Items have a starting price and an ending time
  - Other users can 'bid' on an item. A bid must be higher than all previous bids
  - At the ending time, the user with highest bid wins the item
- **What queries or changes to data are needed for each page?**
  - **Landing Page**
    - Items sorted by price
    - Items sorted by ending time
    - Items sorted by views
    - Search for items by name
  - **Sign In**
    - Find a user with given user name
    - Create a session (auth)
    - Find a session (auth)
    - Get a user with a given ID (auth)
  - **Sign Up**
    - Create a user
  - **Item Create**
    - Create an item
  - **Item Show**
    - Fetch an item with a given ID
    - Find the # of likes tied to an item
    - Like an item
    - Unlike an item
    - See if current user likes an item
    - Create a bid tied to an item
    - Find the bid history of an item
    - Find items similar to an existing item
    - Increment the number of views for an item
  - **Seller Profile**
    - Find items a user likes
    - Find items two different users both like
  - **Dashboard**
    - Find items created by a user, sorted by various criteria

&nbsp;

![reducing-the-design-to-queries](00-diagrams/reducing-the-design-to-queries.png)

&nbsp;

- **"Things" in Our App**
  - users
  - sessions
  - items
  - bids
  - views
  - likes
- **Which of these should be stored as hashes?**
  - **Reasons to Store as Hash**
    - The record has many attributes
    - A collection of these records have to be sorted many different ways
    - Often need to access a single record at a time
    - users, sessions & items
  - **Don't Use Hashes When...**
    - The record is only for counting or enforcing uniqueness
    - Record stores only one or two attributes
    - Used only for creating relations between different records
    - The record is only used for time series data
    - bids, views & likes
- **Serialization:**
  - The process of converting a data structure or object state into a format that can be stored or transmitted and then reconstructed later.
  - Takes the data we're trying to save, returns a new object with the correct fields + correct values
- **Deserialization:**
  - It takes a series of bytes or a string (usually one that was created by serialization), and reconstructs the original data structure or object from it.
  - Turns strings into numbers
  - Adds the ID
  - Turns createdAt into a Date object
- **Date Time Formats**
  - Redis cannot search for or sort
    - 1994-11-05T08:15:30-05:00
    - 'Thu Mar 17 1994 10:56:16 GMT-0500 (Central Daylight Time)'
  - Unix time. Seconds since Jan 1 1970
    - 1047132834625
    - 1047132834625000 (Milliseconds)

&nbsp;

![session-sign-up](00-diagrams/session-sign-up.png)

&nbsp;

---

&nbsp;
