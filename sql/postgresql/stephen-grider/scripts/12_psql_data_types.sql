-- ==========================
-- Type casting in PostgreSQL
-- ==========================
SELECT (1.99999::REAL - 1.99998::REAL); -- Output: 1.001358e-05
SELECT (1.99999::NUMERIC - 1.99998::NUMERIC); -- Output: 0.00001
SELECT (1.99999::DECIMAL - 1.99998::DECIMAL); -- Output: 0.00001
SELECT ('a'::VARCHAR(5)); -- Output: "a"
SELECT (1::BOOLEAN); -- Output: true
SELECT ('NOV-20-1980'::DATE); -- Output: "1980-11-20"
SELECT ('01:23 PM'::TIME); -- Output: "13:23:00"
SELECT ('01:23:23 PM'::TIME WITHOUT TIME ZONE); -- Output: "13:23:23"
SELECT ('01:23:23 AM SGT'::TIME WITH TIME ZONE); -- Output: "01:23:23+08:00"
SELECT ('NOV-20-1981 01:23:23 AM SGT'::TIMESTAMP WITH TIME ZONE); -- Output: "1981-11-20 01:23:23+07:30"
SELECT ('1D 20H 30M 45S'::INTERVAL) - ('1D'::INTERVAL); -- Output: "20:30:45"
