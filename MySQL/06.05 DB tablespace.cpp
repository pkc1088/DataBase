
SHOW VARIABLES LIKE 'innodb_file_per_table';

SHOW VARIABLES LIKE 'innodb_data_file_path';

-- <½Ç½À 7> --

CREATE TABLESPACE ts_a ADD DATAFILE 'ts_a.ibd';
CREATE TABLESPACE ts_b ADD DATAFILE 'ts_b.ibd';
CREATE TABLESPACE ts_c ADD DATAFILE 'ts_c.ibd';

USE sqldb;
CREATE TABLE table_a (id INT) TABLESPACE ts_a;

CREATE TABLE table_b (id INT);
ALTER TABLE table_b TABLESPACE ts_b;

CREATE TABLE table_c (SELECT * FROM employees.salaries);
ALTER TABLE table_c TABLESPACE ts_c;

DROP TABLE  table_c ;
CREATE TABLE table_c (SELECT * FROM employees.salaries);
ALTER TABLE table_c TABLESPACE ts_c;

