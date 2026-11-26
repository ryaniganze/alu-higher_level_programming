-- 15: Count how many records have each score
-- Display score and number, ordered by number descending.
SELECT score, COUNT(*) AS number
FROM second_table
GROUP BY score
ORDER BY number DESC;
