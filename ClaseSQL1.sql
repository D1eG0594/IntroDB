
--SQL
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

--DML

INSERT INTO tabla1 (name, password) VALUES ('Diego', 1234)

--a------------------------------------------------------------------------------------------------------------------------------------------
--Postgres
Create database prueba1;
USE prueba1;
CREATE TABLE tabla1(
	id SERIAL primary key,
    name varchar(30));
    
DROP TABLE tabla1;

CREATE TABLE IF NOT EXISTS tabla1(
	id SERIAL primary key,
    name varchar(30)
   );
    
SHOW DATABASES;

create schema prueba1; #Crear esquema
DROP SCHEMA prueba1; #Borrar esquema


ALTER TABLE tabla1 ADD COLUMN password int; 
ALTER TABLE tabla1 ALTER COLUMN password set DEFAULT 1234; --Modificar tabla
ALTER TABLE tabla1 DROP COLUMN password;

DESCRIBE tabla1;

--DML

INSERT INTO tabla1 (name, password) VALUES ('Diego', 1234);
INSERT INTO tabla1 (name, password) VALUES ('Jose', 7854);
INSERT INTO tabla1 (name, password) VALUES ('Carlos', 5641);

update tabla1 set password ='1234'; --Cambia todas las filas
update tabla1 set password ='9876' where id='3';

delete from tabla1 where name = 'Carlos';  --Eliminar


--DCL

create user usuario1 with password 'contraseña';
update user set password = 'nueva_contraseña'; where usename = 'usuario1';
drop user usuario1

grant select, insert, update, delete on tabla1 to usuario1;
revoke select. insert, update, delete on tabla1 from usuario1;

--DQL

select * from tabla1;
select * from tabla1 where id='2';
select * from tabla1 where name like '%j%'; --%a termina en a, a% empieza en a, %a% tiene a en cualquier parte, importa si es mayucula o minuscula

select name, password from tabla1; --Seleccionar los datos de una colomna o varias

select name as tablaName from tabla1; --Modificar le nombre de una columna temporalmene

select count(*) from tabla1; #Saber cunatas filas tiene la tabla

------------------------------------------
create table if not exists grades (
	code int primary key,
	name varchar(10) not null,
	grade decimal default 0.0

);

insert into grades(code, name, grade) values (123, 'Juan', 3.1);
insert into grades(code, name, grade) values (436, 'Juana', 3.5);
insert into grades(code, name, grade) values (145, 'Juanita', 3.8);
insert into grades(code, name, grade) values (165, 'Carlos', 3.3);
insert into grades(code, name, grade) values (143, 'David', 3.9);
insert into grades(code, name, grade) values (657, 'Sara', 4.0);
insert into grades(code, name, grade) values (765, 'Daniel', 2.9);
insert into grades(code, name, grade) values (147, 'Daniel', 4.5);
insert into grades(code, name) values (859, 'Kevin');

drop table grades; 


select sum(grade) as sum_total from grades; --Suma todas las filas de una columna.
select round(avg(grade),1) as AvgGrade, max(grade) as MaxGrade, min(grade) as MinGrade from grades; --Promedio, calor maxion y valor minimo.


select grade from grades limit 5;
select grade from grades order by grade desc;
select grade from grades order by grade desc limit 4;

select grade from grades limit 3 offset 5; --Primero cuantas filas quero traer y despues desde cual fila empieza a mostrar

select name, count(*) from grades group by name;
