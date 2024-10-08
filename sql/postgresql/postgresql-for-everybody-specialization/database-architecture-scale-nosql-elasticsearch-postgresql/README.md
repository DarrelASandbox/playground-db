- [About The Project](#about-the-project)
- [Module 1](#module-1)
  - [Database Normalization](#database-normalization)
    - [Objectives of Normalization](#objectives-of-normalization)
    - [Normal Forms](#normal-forms)
      - [1. First Normal Form (1NF)](#1-first-normal-form-1nf)
      - [2. Second Normal Form (2NF)](#2-second-normal-form-2nf)
      - [3. Third Normal Form (3NF)](#3-third-normal-form-3nf)
      - [4. Boyce-Codd Normal Form (BCNF)](#4-boyce-codd-normal-form-bcnf)
      - [5. Fourth Normal Form (4NF)](#5-fourth-normal-form-4nf)
      - [6. Fifth Normal Form (5NF)](#6-fifth-normal-form-5nf)
    - [Advantages of Normalization](#advantages-of-normalization)
    - [Disadvantages of Normalization](#disadvantages-of-normalization)
    - [Denormalization](#denormalization)
    - [Summary of Normal Forms](#summary-of-normal-forms)
    - [Conclusion](#conclusion)
  - [ACID vs. BASE: A Comparison of Database Models](#acid-vs-base-a-comparison-of-database-models)
    - [What is ACID?](#what-is-acid)
      - [Key Characteristics of ACID](#key-characteristics-of-acid)
    - [What is BASE?](#what-is-base)
      - [Key Characteristics of BASE](#key-characteristics-of-base)
    - [Comparison of ACID vs. BASE](#comparison-of-acid-vs-base)
    - [When to Use ACID](#when-to-use-acid)
    - [When to Use BASE](#when-to-use-base)
    - [Conclusion](#conclusion-1)
  - [To Multi-Master or not to Multi-Master - that is the question](#to-multi-master-or-not-to-multi-master---that-is-the-question)
    - [Position: In Favor of Switching to a Multi-Master Approach](#position-in-favor-of-switching-to-a-multi-master-approach)
- [Module 2](#module-2)
  - [On ACID and BASE Architectures](#on-acid-and-base-architectures)
    - [ACID vs. BASE: The Eternal Tug-of-War](#acid-vs-base-the-eternal-tug-of-war)
- [Module 3](#module-3)
  - [`sh`](#sh)

# About The Project

- [Database Architecture, Scale, and NoSQL with Elasticsearch](https://www.coursera.org/learn/database-architecture-scale-nosql-elasticsearch-postgresql)

# Module 1

## Database Normalization

Database normalization is the process of organizing data in a relational database to reduce redundancy and improve data integrity. This technique involves decomposing large, complex tables into smaller, related tables while maintaining data consistency.

### Objectives of Normalization

- **Eliminate Redundant Data**: Prevent storing the same data in multiple places.
- **Ensure Data Integrity and Consistency**: Avoid anomalies during insert, update, or delete operations.
- **Improve Query Performance**: Streamline data retrieval and manipulation.

### Normal Forms

Normalization is achieved through a series of stages, each called a **normal form (NF)**. Each subsequent form builds upon the rules of the previous one.

#### 1. First Normal Form (1NF)

- Ensures that each column contains **atomic values** (indivisible).
- Removes **repeating groups** or arrays within a table.

**Example:**

| **StudentID** | **Courses**   |
| ------------- | ------------- |
| 1             | Math, Science |

**1NF Conversion:**

| **StudentID** | **Course** |
| ------------- | ---------- |
| 1             | Math       |
| 1             | Science    |

---

#### 2. Second Normal Form (2NF)

- Meets all requirements of 1NF.
- Ensures all non-key attributes are fully dependent on the **primary key** (eliminates partial dependency).

**Example:**

| **StudentID** | **CourseID** | **CourseName** |
| ------------- | ------------ | -------------- |

**2NF Conversion:**

- Split into two tables:

  1. **Students_Courses**:

     | **StudentID** | **CourseID** |
     | ------------- | ------------ |

  2. **Courses**:

     | **CourseID** | **CourseName** |
     | ------------ | -------------- |

---

#### 3. Third Normal Form (3NF)

- Meets all requirements of 2NF.
- Removes **transitive dependencies** (non-key attributes depending on other non-key attributes).

**Example:**

| **StudentID** | **CourseID** | **InstructorName** |
| ------------- | ------------ | ------------------ |

**3NF Conversion:**

- Split into:

  1. **Students_Courses**:

     | **StudentID** | **CourseID** |
     | ------------- | ------------ |

  2. **Instructors**:

     | **CourseID** | **InstructorName** |
     | ------------ | ------------------ |

---

#### 4. Boyce-Codd Normal Form (BCNF)

- A stricter version of 3NF.
- Ensures that every **determinant** is a candidate key.

---

#### 5. Fourth Normal Form (4NF)

- Removes **multi-valued dependencies**.
- Ensures each table represents a single relationship.

---

#### 6. Fifth Normal Form (5NF)

- Decomposes tables further to ensure **lossless joins**.
- Guarantees that all join dependencies are preserved.

---

### Advantages of Normalization

- Reduces data redundancy.
- Ensures data consistency and integrity.
- Simplifies database maintenance.
- Improves query performance in transactional systems.

### Disadvantages of Normalization

- Can lead to a large number of tables, increasing complexity.
- Joins may reduce query performance, especially in complex databases.
- Not always suitable for **read-heavy systems** like data warehouses.

### Denormalization

- **Definition**: The process of introducing redundancy to improve performance in specific scenarios.
- Commonly used in **OLAP** systems or for **reporting** where quick data retrieval is prioritized.

---

### Summary of Normal Forms

| **Normal Form** | **Key Criteria**                         |
| --------------- | ---------------------------------------- |
| **1NF**         | Atomic values, no repeating groups       |
| **2NF**         | No partial dependency on the primary key |
| **3NF**         | No transitive dependency                 |
| **BCNF**        | Every determinant is a candidate key     |
| **4NF**         | No multi-valued dependencies             |
| **5NF**         | Ensures lossless joins                   |

---

### Conclusion

Database normalization is an essential process for designing efficient, reliable, and scalable relational databases. By reducing redundancy and improving data integrity, normalization ensures robust and maintainable database structures. However, the level of normalization depends on the specific requirements of the application and its performance needs.

## ACID vs. BASE: A Comparison of Database Models

In database systems, two key models define the trade-offs between consistency, availability, and performance: **ACID** and **BASE**. These models represent different approaches to handling data integrity and scalability in distributed systems.

---

### What is ACID?

**ACID** stands for **Atomicity, Consistency, Isolation, and Durability**. It defines a set of properties that guarantee reliable transaction processing in relational databases.

#### Key Characteristics of ACID

- **Atomicity**

  - Ensures that a transaction is treated as a single, indivisible unit.
  - If any part of the transaction fails, the entire transaction is rolled back.
  - Example: Transferring money between accounts must either fully complete or not happen at all.

- **Consistency**

  - Ensures that a database remains in a valid state before and after a transaction.
  - Example: After a transaction, all constraints (e.g., foreign keys) are satisfied.

- **Isolation**

  - Ensures that concurrent transactions do not interfere with each other.
  - Example: Reading uncommitted data from another transaction is prevented.

- **Durability**
  - Ensures that once a transaction is committed, it remains persistent, even in the event of a system crash.
  - Example: Data is safely written to disk after a successful transaction.

---

### What is BASE?

**BASE** stands for **Basically Available, Soft State, and Eventual Consistency**. It defines a model commonly used in distributed, non-relational databases, where high availability and scalability are prioritized over strict consistency.

#### Key Characteristics of BASE

- **Basically Available**

  - Guarantees availability of the data, even if some parts of the system are experiencing failures.
  - Example: In a distributed system, some nodes may respond slower, but the system remains operational.

- **Soft State**

  - The system's state may change over time, even without new input, due to eventual consistency mechanisms.
  - Example: Data replication across nodes may temporarily lead to different values.

- **Eventual Consistency**
  - Guarantees that all nodes will eventually converge to the same state.
  - Example: Updates to a distributed database are propagated asynchronously, but all replicas will eventually reflect the same value.

---

### Comparison of ACID vs. BASE

| **Feature**          | **ACID**                                      | **BASE**                                        |
| -------------------- | --------------------------------------------- | ----------------------------------------------- |
| **Consistency**      | Strong (always consistent after transactions) | Eventual (may be temporarily inconsistent)      |
| **Availability**     | Limited during failures                       | High availability, even during failures         |
| **Scalability**      | Limited (vertical scaling)                    | High (horizontal scaling)                       |
| **Transaction Type** | Suitable for complex, critical transactions   | Suitable for simple, high-throughput operations |
| **Use Cases**        | Banking, financial systems, inventory         | Social media, e-commerce, content delivery      |

---

### When to Use ACID

- Applications where **data integrity** is critical.
- Systems that require strong **consistency** and reliable transactions.
- Examples:
  - Banking and financial systems.
  - Inventory management.
  - Flight booking systems.

---

### When to Use BASE

- Applications that prioritize **high availability** and **scalability** over strict consistency.
- Systems where **eventual consistency** is acceptable for performance gains.
- Examples:
  - Social media platforms.
  - E-commerce systems.
  - Content delivery networks (CDNs).

---

### Conclusion

The choice between **ACID** and **BASE** depends on the specific needs of your application. While ACID provides robust data consistency and reliability, BASE offers flexibility and scalability for high-availability systems. Understanding their differences is crucial for designing efficient, resilient databases tailored to your use case.

## To Multi-Master or not to Multi-Master - that is the question

Your organization is reaching the limits of its relational database application as it scales and you are in meeting to decide to move to a multi-master approach or not. Expanding the size of the single-master instance is quite expensive and requires a long-term contract. The multi-master approach is much less expensive and can use commodity hardware. Take a position for or against the switch to multi-master proposal. Write 3-5 paragraphs and share your reasoning on the position you have taken. Feel free to bring prior experience that you might have into the conversation. Feel free to now more than the instructor on this topic :) Let's see what we can learn from talking and listening to each other's perspectives. The primary goal is to have a conversation.

Don't take off points for little mistakes. If they seem to have done the assignment give them full credit. Feel free to make suggestions if there are small mistakes. Please keep your comments positive and useful. If you do not take grading seriously, the instructors may delete your response and you will lose points.

### Position: In Favor of Switching to a Multi-Master Approach

The multi-master approach offers significant advantages, particularly for organizations that are scaling beyond the limits of their current single-master relational database. One of the primary benefits of a multi-master setup is its ability to distribute both read and write operations across multiple nodes. This distribution improves system availability, reduces the risk of bottlenecks, and ensures high uptime. Furthermore, because it can run on commodity hardware, a multi-master system provides a cost-effective solution compared to the substantial costs and contractual obligations tied to expanding a single-master instance.

Multi-master databases excel in scenarios where scalability, fault tolerance, and availability are critical. Organizations with geographically distributed users, high transaction volumes, or the need for continuous system availability benefit greatly from this approach. For example, multi-master replication allows users in different regions to interact with their nearest database node, reducing latency and enhancing user experience. Additionally, in the event of node failure, the system can continue to operate without significant disruption, minimizing downtime risks.

From a financial perspective, understanding the organization’s budget and whether database costs can be passed on to clients is crucial. If the database is solely a cost to the organization, a multi-master approach might provide a more budget-friendly alternative due to its reliance on cheaper hardware and open-source solutions. However, if clients or stakeholders expect high availability and low latency, the enhanced performance provided by multi-master setups may justify the investment. Additionally, assessing the long-term duration of the project is essential; if the application is expected to grow and serve a larger user base over time, the scalability of multi-master systems becomes an invaluable asset.

That said, it’s essential to evaluate whether the organization can sustain its operations without this shift. The risks of not adopting a multi-master system include potential performance degradation, increased latency, and higher likelihood of downtime due to the single point of failure in a single-master architecture. These risks could lead to client dissatisfaction, revenue loss, and damage to the organization’s reputation. While transitioning to a multi-master system requires careful planning, testing, and potential refactoring of the application, the long-term benefits—both technical and financial—make it a viable and forward-thinking choice for scaling operations effectively.

# Module 2

## On ACID and BASE Architectures

The topic for this week is to compare, contrast, and explore the interplay between ACID and BASE style architectures. In this mini-paper (3-5 paragraphs) explain your take or views on these competing approaches to database architecture. Feel free to bring prior experience that you might have into the conversation. It is quite OK to take and support a position that is different from the position in this week's lectures. Let's see what we can learn from talking and listening to each other's perspectives. The main goal is to have a conversation.

Don't take off points for little mistakes. Feel free to make suggestions if there are small mistakes. Please keep your comments positive and useful. Provide comments that will help us all think about the question that is posed. Some of the points will be given by the instructors - it might take a while for the instructor points to appear.

### ACID vs. BASE: The Eternal Tug-of-War

ACID (Atomicity, Consistency, Isolation, Durability) and BASE (Basically Available, Soft-state, Eventually consistent) are paradigms on opposite ends of the database spectrum. ACID is ideal for transactional systems like banking, where data integrity is critical, while BASE excels in high-availability systems such as social media or e-commerce, where speed and scale trump immediate consistency. The key difference lies in the trade-off between consistency and availability, especially in distributed systems.

ACID ensures strict data integrity and is straightforward to reason about, but it suffers from limited scalability and higher latencies, making it less suitable for modern distributed architectures. Conversely, BASE offers high performance and availability at massive scales but sacrifices strong consistency, which can lead to user confusion (“Why does my post show up for me but not my friend?”). ACID systems are often easier to debug, while BASE systems require a deeper understanding of eventual consistency and conflict resolution strategies.

ACID systems typically require costly hardware to maintain performance under high transactional loads and are challenging to scale horizontally. BASE, on the other hand, thrives on commodity hardware, minimizing infrastructure costs. However, the operational complexity of BASE (e.g., implementing conflict resolution or eventual consistency checks) can drive up engineering costs. For small-to-midsize businesses, ACID is manageable, but at web-scale (think Netflix or Amazon), BASE becomes the only viable option.

For future-proofing, the choice often depends on anticipated growth. An ACID-first approach is suitable for systems with manageable growth or stringent consistency needs. For rapidly scaling applications, adopting BASE early avoids costly migrations later. A hybrid approach, using BASE for high-traffic components and ACID for critical data, can provide a balanced path forward.

Of course, the biggest constraint is the budget, followed closely by resistance from stakeholders who fear the complexity of BASE or the “over-engineering” of ACID. Convincing a business team to prioritize system resiliency over “just ship it” timelines can feel like trying to push a camel through the eye of a needle. At the end of the day, the database architecture is often less about technical superiority and more about which side wins the budget battle!

# Module 3

- [email list](https://mbox.dr-chuck.net/sakai.devel/4/5)
- [pg20203](https://www.pg4e.com/gutenberg/cache/epub/20203/pg20203.txt)

## `sh`

```sh
conda activate temp
python database-architecture-scale-nosql-elasticsearch-postgresql/py/elastictool.py
python database-architecture-scale-nosql-elasticsearch-postgresql/py/elasticmail.py
python database-architecture-scale-nosql-elasticsearch-postgresql/py/elastictweet.py
python database-architecture-scale-nosql-elasticsearch-postgresql/py/elasticbook.py
# database-architecture-scale-nosql-elasticsearch-postgresql/pg20203.txt
# Index refreshed pg4e_641a0552b5
# {'_shards': {'total': 2, 'successful': 1, 'failed': 0}}
#
# Loaded 987 paragraphs 8561 lines 446409 characters
#
# Enter command: search pennsylvania
```
