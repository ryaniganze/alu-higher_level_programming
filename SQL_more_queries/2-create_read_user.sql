-- Create the database if it does not exist.
CREATE DATABASE IF NOT EXISTS hbtn_0d_2;

-- Create the user if it does not exist.
CREATE USER IF NOT EXISTS 'user_0d_2'@'localhost'
IDENTIFIED BY 'user_0d_2_pwd';

-- Remove any previous privileges from this user.
REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'user_0d_2'@'localhost';

-- Grant only SELECT and INSERT privileges on the database.
GRANT SELECT, INSERT ON hbtn_0d_2.*
TO 'user_0d_2'@'localhost';
