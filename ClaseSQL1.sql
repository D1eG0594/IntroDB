
#SQL
Create database prueba1;
USE prueba1;
CREATE TABLE tabla1(
	id INT auto_increment primary key,
    name varchar(30));
    
DROP TABLE tabla1;

CREATE TABLE IF NOT EXISTS tabla1(
	id INT auto_increment primary key,
    name varchar(30)

);
    
SHOW DATABASES;

DROP SCHEMA prueba1;

ALTER TABLE tabla1 ADD COLUMN password int; 
ALTER TABLE tabla1 ALTER COLUMN password set DEFAULT 1234;
ALTER TABLE tabla1 DROP COLUMN password;

DESCRIBE tabla1;

#DML

INSERT INTO tabla1 (name, password) VALUES ('Diego', 1234)

