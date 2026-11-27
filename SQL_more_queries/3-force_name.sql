-- 3: Create force_name with id and a name that cannot be NULL
-- Create the table only if it does not already exist.
CREATE TABLE IF NOT EXISTS force_name (
    id INT,
    name VARCHAR(256) NOT NULL
);
