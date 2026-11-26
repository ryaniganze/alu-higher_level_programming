-- 9: List all cities with their corresponding state names
-- Match each city to its state using the state ID.
SELECT cities.id, cities.name, states.name
FROM cities
JOIN states ON cities.state_id = states.id
ORDER BY cities.id ASC;
