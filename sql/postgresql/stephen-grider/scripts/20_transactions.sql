-- ==========================
-- Dummy Account Creation
-- ==========================
CREATE table
  accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    balance INTEGER NOT NULL
  );

INSERT INTO
  accounts (name, balance)
VALUES
  ('Gia', 100),
  ('Alyson', 100);

SELECT
  *
FROM
  accounts;

-- ==========================
-- UPDATE USING Transaction
-- ==========================
BEGIN;

UPDATE accounts
SET
  balance = balance - 50
WHERE
  name = 'Alyson';

UPDATE accounts
SET
  balance = balance + 50
WHERE
  name = 'Gia';

-- ROLLBACK;
COMMIT;

-- ==========================
--  Reset bank balances
-- ==========================
UPDATE accounts
SET
  balance = 100;