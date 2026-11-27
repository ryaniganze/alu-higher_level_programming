-- 8: List all cities belonging to California without using JOIN
-- Find the California state ID using a subquery.
SELECT id, name
FROM cities
WHERE state_id = (
    SELECT id
    FROM states
    WHERE name = 'California'
)
ORDER BY id ASC;
