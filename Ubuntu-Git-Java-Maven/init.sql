CREATE DATABASE IF NOT EXISTS global_site_db;

CREATE USER 'springuser'@'%' IDENTIFIED BY 'springpassword';

GRANT ALL PRIVILEGES ON global_site_db.* TO 'springuser'@'%' IDENTIFIED BY 'springpassword';

GRANT PROXY ON 'root'@'%' TO 'springuser'@'%' IDENTIFIED BY 'springpassword' WITH GRANT OPTION;