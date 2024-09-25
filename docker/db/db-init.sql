DROP DATABASE IF EXISTS project_name;
CREATE DATABASE project_name;

CREATE USER IF NOT EXISTS 'project_name'@'%' IDENTIFIED BY '1122';
GRANT ALL PRIVILEGES ON project_name.* TO 'project_name'@'%';