-- ON DELETE options specify what happens when a referenced record in the parent table is deleted.
-- 1. ON DELETE RESTRICT
-- Prevents deletion of a referenced record in the parent table.
CREATE TABLE
    parent (id INT PRIMARY KEY);

CREATE TABLE
    child (
        id INT PRIMARY KEY,
        parent_id INT,
        FOREIGN KEY (parent_id) REFERENCES parent (id) ON DELETE RESTRICT
    );

-- 2. ON DELETE NO ACTION
-- Similar to RESTRICT, prevents deletion if there is a matching record in the child table.
CREATE TABLE
    child2 (
        id INT PRIMARY KEY,
        parent_id INT,
        FOREIGN KEY (parent_id) REFERENCES parent (id) ON DELETE NO ACTION
    );

-- 3. ON DELETE CASCADE
-- Deletes the rows in the child table that match the deleted row in the parent table.
CREATE TABLE
    child3 (
        id INT PRIMARY KEY,
        parent_id INT,
        FOREIGN KEY (parent_id) REFERENCES parent (id) ON DELETE CASCADE
    );

-- 4. ON DELETE SET NULL
-- Sets the foreign key column(s) in the child table to NULL when the corresponding record in the parent table is deleted.
CREATE TABLE
    child4 (
        id INT PRIMARY KEY,
        parent_id INT,
        FOREIGN KEY (parent_id) REFERENCES parent (id) ON DELETE SET NULL
    );

-- 5. ON DELETE SET DEFAULT
-- Sets the foreign key column(s) in the child table to their DEFAULT values when the corresponding record in the parent table is deleted.
CREATE TABLE
    child5 (
        id INT PRIMARY KEY,
        parent_id INT DEFAULT 0,
        FOREIGN KEY (parent_id) REFERENCES parent (id) ON DELETE SET DEFAULT
    );