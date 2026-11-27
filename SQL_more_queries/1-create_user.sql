-- 1: Create user_0d_1 with all privileges on the MySQL server
-- Create the user only if it does not already exist.
CREATE USER IF NOT EXISTS 'user_0d_1'@'localhost'
IDENTIFIED BY 'user_0d_1_pwd';

-- Grant all privileges on the server to the user.
GRANT ALL PRIVILEGES ON *.* TO 'user_0d_1'@'localhost';
