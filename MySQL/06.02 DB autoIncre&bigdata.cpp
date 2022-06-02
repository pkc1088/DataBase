
USE  sqldb;
CREATE TABLE testTbl3 
  (id  int AUTO_INCREMENT PRIMARY KEY, 
   userName char(3), 
   age int );
ALTER TABLE testTbl3 AUTO_INCREMENT=1000;
SET @@auto_increment_increment=3;
INSERT INTO testTbl3 VALUES (NULL, '나연', 20);
INSERT INTO testTbl3 VALUES (NULL, '정연', 18);
INSERT INTO testTbl3 VALUES (NULL, '모모', 19);
SELECT * FROM testTbl3;

USE sqldb;
CREATE TABLE testTbl4 (id int, Fname varchar(50), Lname varchar(50));
INSERT INTO testTbl4 
  SELECT emp_no, first_name, last_name
    FROM employees.employees ;
SELECT * FROM testTbl4 limit 5;

USE sqldb;
CREATE TABLE testTbl5 
   (SELECT emp_no, first_name, last_name  FROM employees.employees) ;
