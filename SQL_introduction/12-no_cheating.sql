-- 12: Update Bob's score to 10 in second_table
-- Identify Bob using the name field, not an id.
UPDATE second_table
SET score = 10
WHERE name = 'Bob';
