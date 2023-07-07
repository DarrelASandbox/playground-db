## Table of Contents

- [About The Project](#about-the-project)
- [Introduction](#introduction)
  - [Redis](#redis)
  - [Setup](#setup)
  - [Commands](#commands)
- [01-rbook_notebooks](#01-rbook_notebooks)
  - [Hashes](#hashes)
  - [Pipelines](#pipelines)
  - [Sets](#sets)
  - [Sorted Sets](#sorted-sets)
  - [Sort](#sort)
  - [HyperLogLog](#hyperloglog)
  - [List](#list)
- [02-rbay](#02-rbay)
  - [E-Commerce App starter files](#e-commerce-app-starter-files)
  - [Design Patterns](#design-patterns)
  - [Concurrency Issue](#concurrency-issue)
- [Lua Basics](#lua-basics)

&nbsp;

# About The Project

- Redis: The Complete Developer's Guide
- Master Redis v7.0 with hands-on exercises. Includes Modules, Scripting, Concurrency, and Streams!
- [Stephen Grider](https://github.com/StephenGrider)

&nbsp;

# Introduction

## Redis

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

## Setup

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

## Commands

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

# 01-rbook_notebooks

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

## Pipelines

- All the commands we have seen work on a single hash
- So how do we handle request that requires details about the cars with IDs 553, 601, 789, 419, 950, 15
  - **Option 1**: Loop over Id's, fetch one at a time (you probably don't want this)
  - **Option 2**: - Pipelining

&nbsp;

---

&nbsp;

## Sets

&nbsp;

![commands-set](00-diagrams/commands-set.png)

&nbsp;

- **Union**: Return all unique elements from all sets
- **Intersect**: Return elements that exist in all sets
- **Diff**: Return elements that exist in the first set, but not any others
- **Use Cases:**
  - Enforcing uniqueness of any value
    - Is the username 'powerseller1' in use? `SISMEMBER usernames powerseller1`
  - Creating a relationship between different records
    - Which items do user with ID 45 like? `SMEMBERS users:likes#45`
  - Finding common attributes between different things
    - How many items does user with ID 45 like? `SCARD users:likes#45`
    - Does user with ID 45 like the item with ID 123? `SISMEMBER users:likes#45 123`
  - General list of elements where order doesn't matter
    - domains:banned: Set of domains
      - ezmail.com
      - freemail.com
      - scammail.com

&nbsp;

---

&nbsp;

## Sorted Sets

&nbsp;

![commands-sorted-set](00-diagrams/commands-sorted-set.png)

&nbsp;

- **Use Cases:**
  - Tabulating 'the most' or 'the least' of a collection of hashes
  - Creating relationships between records, sorted by some criteria

&nbsp;

![auth-flow-set](00-diagrams/auth-flow-set.png)

&nbsp;

![auth-flow-sorted-set](00-diagrams/auth-flow-sorted-set.png)

&nbsp;

---

&nbsp;

## Sort

- Used on sets, sorted sets, and lists

&nbsp;

---

&nbsp;

## HyperLogLog

- Algorithm for _approximately_ counting the number of unique elements
- Similar to a set, but doesn't store the elements
- Drawback
  - 1000 add's, each with a unique value
  - `PFCOUNT views`
  - 0.81% error, so 991 to 1008

&nbsp;

![hyperloglog-set-size](00-diagrams/hyperloglog-set-size.png)

&nbsp;

![hyperloglog-size](00-diagrams/hyperloglog-size.png)

&nbsp;

---

&nbsp;

## List

- Store an ordered list of strings
- Not an array! Not an array! Not an array!
- Implemented as a doubly-linked list
- Often used for time-series data
- You should probably use this less often than you think

&nbsp;

![commands-lists](00-diagrams/commands-lists.png)

&nbsp;

- **Use Cases:**
  - Append-only or prepend-only data (temperature readings, stock values)
  - When you only need the last/first N values of something
  - Your data has no sort order besides the order it was inserted
  - Don't use lists if you have many items AND...
    - You need to apply some filtering criteria
    - Your data is sorted by some attribute

&nbsp;

![example-list-book-revieweing-platform](00-diagrams/example-list-book-revieweing-platform.png)

&nbsp;

```redis
DEL reviews

RPUSH reviews b2
RPUSH reviews a1

HSET books:a1 title 'Good Book'
HSET books:b2 title 'Bad Book'

SORT reviews BY nosort GET books:*->title
```

&nbsp;

![example-list-temperature-station](00-diagrams/example-list-temperature-station.png)

&nbsp;

# 02-rbay

## E-Commerce App starter files

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

## Design Patterns

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

![bids-offset-lrange](00-diagrams/bids-offset-lrange.png)

&nbsp;

![bids-creation](00-diagrams/bids-creation.png)

&nbsp;

## Concurrency Issue

- Input a number in the `Place a Bid` field
- Open dev console and focus the arrow on the `Place Bid` button
- In the console, enter `for (let i = 0; i < 15; i ++ ){$0.click()}`
- Observe that in the network tab there are responses for 200 and 500

&nbsp;

![bids-concurrency-multiple-requests](00-diagrams/bids-concurrency-multiple-requests.png)

&nbsp;

- **Options for Handling Concurrency**
  - Use an atomic update command (like HINCRBY or HSETNX)
  - Use a transaction with the 'WATCH' command
    - Groups together one or more commands to run sequentially
    - Hijacks a connection to Redis
    - Transactions cannot be undone! (Unlike other databases)
  - Use a lock
  - Use a custom LUA update script

&nbsp;

![bids-transactions-watch](00-diagrams/bids-transactions-watch.png)

&nbsp;

![bids-transactions-connection](00-diagrams/bids-transactions-connection.png)

&nbsp;

# Lua Basics

```lua
print(123) -- 123
print('hello world') -- hello world

local sum = 1 + 1
sum = 5
print(sum) --5

if sum > 0 then
  print('Sum is greater than 0.')
end

if sum ~= 0 then
  print('Sum is NOT greater than 0.')
end

if sum == 0 then
  print('Sum is equal to 0.')
end

if 0 and '' then
  print('0 is truthy')
end

if false or not true then
  print('falsy')
end

if nil then
  print("Won't run")
end
```

&nbsp;
