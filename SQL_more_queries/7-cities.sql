-- 7: Create hbtn_0d_usa database if it does not exist
CREATE DATABASE IF NOT EXISTS hbtn_0d_usa;

-- Select the database where the cities table will be created.
USE hbtn_0d_usa;

-- Create cities with a foreign key referencing states.
CREATE TABLE IF NOT EXISTS cities (
    id INT NOT NULL AUTO_INCREMENT UNIQUE,
    state_id INT NOT NULL,
    name VARCHAR(256) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (state_id) REFERENCES states(id)
);
