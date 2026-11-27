-- 5: Create unique_id with a unique ID defaulting to 1
-- Create the table only if it does not already exist.
CREATE TABLE IF NOT EXISTS unique_id (
    id INT DEFAULT 1 UNIQUE,
    name VARCHAR(256)
);
