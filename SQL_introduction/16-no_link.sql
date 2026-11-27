-- 16: List records that have a name value
-- Display score first, then name, ordered by score descending.
SELECT score, name
FROM second_table
WHERE name IS NOT NULL
ORDER BY score DESC;
