
/* 09�� */
create schema indexdb;
CREATE TABLE usertbl 
( userID  CHAR(8) NOT NULL PRIMARY KEY, 
  name    VARCHAR(10) NOT NULL, 
  birthYear   INT NOT NULL,  
  addr	  CHAR(2) NOT NULL,
  mobile1	CHAR(3) NULL, 
  mobile2   CHAR(8) NULL, 
  height    SMALLINT NULL, 
  mDate    DATE NULL 
);

-- <�ǽ� 1> --


CREATE TABLE  tbl1
	(	a INT PRIMARY KEY,
		b INT,
		c INT
	);

SHOW INDEX FROM tbl1;

CREATE TABLE  tbl2
	(	a INT PRIMARY KEY,
		b INT UNIQUE,
		c INT UNIQUE,
		d INT
	);
SHOW INDEX FROM tbl2;

CREATE TABLE  tbl3
	(	a INT UNIQUE,
		b INT UNIQUE,
		c INT UNIQUE,
		d INT
	);
SHOW INDEX FROM tbl3;

CREATE TABLE  tbl4
	(	a INT UNIQUE NOT NULL,
		b INT UNIQUE ,
		c INT UNIQUE,
		d INT
	);
SHOW INDEX FROM tbl4;

CREATE TABLE  tbl5
	(	a INT UNIQUE NOT NULL,
		b INT UNIQUE ,
		c INT UNIQUE,
		d INT PRIMARY KEY
	);
SHOW INDEX FROM tbl5;	// -- primary�� ������ unique not null���� �켱��������



CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl 
( userID  char(8) NOT NULL PRIMARY KEY, 
  name    varchar(10) NOT NULL,
  birthYear   int NOT NULL,
  addr	  nchar(2) NOT NULL 
 );


INSERT INTO usertbl VALUES('LSG', '�̽±�', 1987, '����');
INSERT INTO usertbl VALUES('KBS', '�����', 1979, '�泲');
INSERT INTO usertbl VALUES('KKH', '���ȣ', 1971, '����');
INSERT INTO usertbl VALUES('JYP', '������', 1950, '���');
INSERT INTO usertbl VALUES('SSK', '���ð�', 1979, '����');
SELECT * FROM usertbl;

ALTER TABLE usertbl DROP PRIMARY KEY ;
ALTER TABLE usertbl 
	ADD CONSTRAINT pk_name PRIMARY KEY(name);
SELECT * FROM usertbl; 
