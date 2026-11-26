-- 6: Create hbtn_0d_usa database if it does not exist
CREATE DATABASE IF NOT EXISTS hbtn_0d_usa;

-- Select the database where the states table will be created.
USE hbtn_0d_usa;

-- Create states with an auto-generated primary key and required name.
CREATE TABLE IF NOT EXISTS states (
    id INT NOT NULL AUTO_INCREMENT UNIQUE,
    name VARCHAR(256) NOT NULL,
    PRIMARY KEY (id)
);
