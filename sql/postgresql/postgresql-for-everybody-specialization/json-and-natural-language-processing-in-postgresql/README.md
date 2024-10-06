- [About The Project](#about-the-project)
- [Module 1](#module-1)
  - [`unnest` Benchmark](#unnest-benchmark)
  - [`EXPLAIN` Output for `unnest(ARRAY[generate_series(1, size)])`](#explain-output-for-unnestarraygenerate_series1-size)
- [Module 2](#module-2)
  - [What is `tsvector`?](#what-is-tsvector)
  - [What is `tsquery`?](#what-is-tsquery)
  - [Common Functions](#common-functions)
  - [Indexing for Performance](#indexing-for-performance)
  - [Practical Use Cases](#practical-use-cases)
- [Module 3](#module-3)
  - [`sh`](#sh)
- [Module 4](#module-4)
  - [`sh`](#sh-1)
  - [Understanding PostgreSQL JSONB and Its Comparison to Document Databases](#understanding-postgresql-jsonb-and-its-comparison-to-document-databases)
    - [What is JSONB?](#what-is-jsonb)
    - [Similarities Between PostgreSQL JSONB and Document Databases](#similarities-between-postgresql-jsonb-and-document-databases)
      - [Document Storage](#document-storage)
      - [Flexible Schema](#flexible-schema)
      - [Rich Query Capabilities](#rich-query-capabilities)
      - [Indexing](#indexing)
      - [Data Retrieval and Filtering](#data-retrieval-and-filtering)
    - [Differences Between PostgreSQL JSONB and Document Databases](#differences-between-postgresql-jsonb-and-document-databases)
  - [Differences Between PostgreSQL JSONB and Document Databases](#differences-between-postgresql-jsonb-and-document-databases-1)
    - [Conclusion](#conclusion)

# About The Project

- [JSON and Natural Language Processing in PostgreSQL](https://www.coursera.org/learn/json-natural-language-processing-postgresql)
- [PostgreSQL Full Text Lecture Notes](https://www.pg4e.com/lectures/05-FullText.php)
- [PostgreSQL / Python Lecture Notes](https://www.pg4e.com/lectures/06-Python.php)
- [JSON Lecture Notes](https://www.pg4e.com/lectures/06-JSON.php)

# Module 1

## `unnest` Benchmark

```sql
DO $$
DECLARE
    size INT;
    sizes INT[] := ARRAY[100000, 1000000, 10000000, 100000000];
    explain_line TEXT;
BEGIN
    -- Create a temporary table to store the EXPLAIN output
    CREATE TEMP TABLE explain_output_table (output TEXT);

    FOREACH size IN ARRAY sizes LOOP
        RAISE NOTICE 'Testing array size: %', size;

        -- Use a loop to insert each line of EXPLAIN output into the table
        FOR explain_line IN
            EXECUTE format(
                $f$ EXPLAIN (FORMAT TEXT) SELECT unnest(ARRAY[generate_series(1, %s)]) $f$,
                size
            )
        LOOP
            INSERT INTO explain_output_table (output) VALUES (explain_line);
        END LOOP;
    END LOOP;

    -- Display the contents of the temporary table
    FOR explain_line IN SELECT output FROM explain_output_table LOOP
        RAISE NOTICE '%', explain_line;
    END LOOP;

    -- Drop the temporary table to clean up
    DROP TABLE explain_output_table;
END $$;
```

## `EXPLAIN` Output for `unnest(ARRAY[generate_series(1, size)])`

- For each size, PostgreSQL generates an execution plan, which includes:
  - **ProjectSet**: This is the operation responsible for evaluating generate_series and applying unnest. It shows the estimated cost and row count.
  - `cost=0.00..2000.02 rows=100000 width=4` indicates that for 100,000 elements:
  - **Startup cost**: 0.00 (no expensive setup is needed).
  - **Total cost**: 2000.02 (estimated total effort to process).
  - **Rows**: 100,000 (expected number of rows returned).
  - **Width**: 4 bytes (size of each row, corresponding to an INT).
- This pattern repeats for each size, showing how PostgreSQL scales as the array size grows.
- Why This Works.
  - **Dynamic Query Execution**: The `format()` function builds queries for each size dynamically.
  - `EXECUTE` runs the `EXPLAIN` query and provides line-by-line output, which is processed in the `FOR` loop.
  - **Capturing `EXPLAIN` Output**: `EXPLAIN (FORMAT TEXT)` makes the output accessible line by line, allowing you to store it in the table.
  - **Scalable Design**: This structure works for any number of test cases and sizes, making it a reusable benchmarking setup.
- What the Results Tell You
  - `Performance Trend`: As size increases, the cost and row count increase linearly, which aligns with the expected O(n) complexity of unnest.
  - `Validation of Assumptions`: PostgreSQL’s query planner correctly predicts linear scaling in processing larger arrays, confirming the efficiency of unnest.

# Module 2

## What is `tsvector`?

- `tsvector` is a data type in PostgreSQL that stores a normalized, searchable representation of text. It tokenizes and reduces text to lexemes (normalized word forms) to facilitate fast searching and indexing.
- **Key Features**:
  - **Tokenization**: Breaks the text into words or phrases.
  - **Lexeme normalization**: Reduces words to their base forms (e.g., “running” → “run”).
  - **Eliminates stop words**: Common words like “and”, “the”, etc., are removed by default.
- **Example**: `SELECT to_tsvector('english', 'The quick brown fox jumps over the lazy dog');`
- **Output**: `'the':2,9 'brown':3 'dog':9 'fox':4 'jump':5 'lazi':8 'quick':2 'over':6`
- Each lexeme is paired with its positional information `('word':position)`.

## What is `tsquery`?

- `tsquery` is a data type used to search within `tsvector` data. It represents the search terms or phrases and supports logical operators like `& (AND), | (OR), and ! (NOT)`.
- **Example**: `SELECT to_tsquery('english', 'quick & fox');`
- **Output**: `'quick' & 'fox'`
- You can use `tsquery` to match a `tsvector`: `SELECT to_tsvector('english', 'The quick brown fox') @@ to_tsquery('quick & fox');`
- **Output**: `true`

## Common Functions

- `to_tsvector`: Converts plain text into a tsvector.
  - `SELECT to_tsvector('english', 'A rolling stone gathers no moss');`
  - **setweight**: Assigns weights (A, B, C, D) to lexemes, useful for ranking.
  - `SELECT setweight(to_tsvector('english', 'important'), 'A');`
- `to_tsquery`: Converts plain text into a tsquery.
  - `SELECT to_tsquery('english', 'fox & quick');`
  - `plainto_tsquery`: Converts plain text into a tsquery, but assumes simple AND logic.
  - `SELECT plainto_tsquery('english', 'quick fox');`

## Indexing for Performance

- You can use GIN or GiST indexes on `tsvector` columns for fast searching.
- **Example**:

```sql
CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    content TEXT,
    tsv_content TSVECTOR
);

-- Populate tsvector column
UPDATE documents SET tsv_content = to_tsvector('english', content);

-- Create GIN index
CREATE INDEX idx_tsv_content ON documents USING gin(tsv_content);

-- Search with index
SELECT * FROM documents WHERE tsv_content @@ to_tsquery('quick & fox');
```

## Practical Use Cases

- **Search in articles or documents**: Quickly find relevant documents or articles.
- **Autocomplete systems**: Tokenized and indexed text enables fast suggestions.
- **Advanced filtering**: Combine text search with other filters in complex queries.

# Module 3

## `sh`

```sh
conda activate temp
python json-and-natural-language-processing-in-postgresql/py/simple.py
python json-and-natural-language-processing-in-postgresql/py/loadbook.py
python json-and-natural-language-processing-in-postgresql/py/gmane.py
python json-and-natural-language-processing-in-postgresql/py/pyseq.py
```

# Module 4

## `sh`

```sh
conda activate temp
python json-and-natural-language-processing-in-postgresql/py/swapi.py
```

## Understanding PostgreSQL JSONB and Its Comparison to Document Databases

PostgreSQL's JSONB data type enables flexible storage of semi-structured data, resembling the functionality of document-oriented databases like MongoDB. This document explores the similarities, differences, and use cases of PostgreSQL JSONB compared to typical document databases.

### What is JSONB?

- **JSONB (Binary JSON)** is a binary format for storing JSON data in PostgreSQL.
- Optimized for efficient querying and manipulation of JSON documents.
- Offers support for indexing and various operators for advanced data handling.

### Similarities Between PostgreSQL JSONB and Document Databases

#### Document Storage

- Both PostgreSQL JSONB and document databases store structured data in key-value pairs, arrays, and nested objects.

#### Flexible Schema

- No fixed schema is required, allowing varying document structures.

#### Rich Query Capabilities

- **PostgreSQL**: Provides operators like `->`, `->>`, `@>`, and functions such as `jsonb_set`.
- **MongoDB**: Uses operators like `$elemMatch`, `$exists`, and `$size`.

#### Indexing

- PostgreSQL supports **GIN (Generalized Inverted Index)** for JSONB fields.
- Document databases support indexes on nested fields, compound keys, and text.

#### Data Retrieval and Filtering

- Both allow querying specific fields or nested keys efficiently.

### Differences Between PostgreSQL JSONB and Document Databases

## Differences Between PostgreSQL JSONB and Document Databases

| Feature                        | PostgreSQL JSONB                                  | Document Databases (e.g., MongoDB)       |
| ------------------------------ | ------------------------------------------------- | ---------------------------------------- |
| **Primary Data Model**         | Relational (tables, rows, columns)                | Document-based                           |
| **Schema Enforcement**         | Relational schema with JSONB fields               | Completely schema-less                   |
| **Query Language**             | SQL with JSONB-specific operators                 | BSON-based query language (NoSQL style)  |
| **Performance**                | Optimized but slower for pure document operations | Optimized for document workloads         |
| **Transactions**               | Fully ACID-compliant, supports multi-table        | ACID-compliant (from version 4.0)        |
| **Indexing**                   | GIN indexes for JSONB fields                      | Field-level and compound indexes         |
| **Scalability**                | Supports horizontal scaling with effort           | Built-in horizontal scaling and sharding |
| **Clustering and Replication** | Streaming replication and clustering available    | Native sharding and replication          |
| **Use Case Fit**               | Hybrid (relational + document storage)            | Pure document-based applications         |

### Conclusion

PostgreSQL JSONB bridges the gap between relational and document databases, making it ideal for hybrid workloads. While it provides many features of document databases, specialized systems like MongoDB excel in pure document-based use cases. The choice between them depends on specific application requirements, including data model, scalability needs, and performance considerations.
