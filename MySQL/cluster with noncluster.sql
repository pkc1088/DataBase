
CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
DROP TABLE IF EXISTS mixedtbl;
CREATE TABLE mixedtbl
( userID  CHAR(8) NOT NULL ,
  name    VARCHAR(10) NOT NULL,
  addr     char(2)
);
INSERT INTO mixedtbl VALUES('LSG', '이승기', '서울');
INSERT INTO mixedtbl VALUES('KBS', '김범수', '경남');
INSERT INTO mixedtbl VALUES('KKH', '김경호', '전남');
INSERT INTO mixedtbl VALUES('JYP', '조용필',  '경기');
INSERT INTO mixedtbl VALUES('SSK', '성시경', '서울');
INSERT INTO mixedtbl VALUES('LJB', '임재범',  '서울');
INSERT INTO mixedtbl VALUES('YJS', '윤종신',  '경남');
INSERT INTO mixedtbl VALUES('EJW', '은지원', '경북');
INSERT INTO mixedtbl VALUES('JKW', '조관우', '경기');
INSERT INTO mixedtbl VALUES('BBK', '바비킴',  '서울');


ALTER TABLE mixedtbl
	ADD CONSTRAINT PK_mixedtbl_userID
		PRIMARY KEY (userID);

ALTER TABLE mixedtbl
	ADD CONSTRAINT UK_mixedtbl_name
		UNIQUE (name) ;

SHOW INDEX FROM mixedtbl;

SELECT addr FROM mixedtbl WHERE name = '임재범';


USE sqldb;
SELECT * FROM usertbl;

USE sqldb;
SHOW INDEX FROM usertbl;

SHOW TABLE STATUS LIKE 'usertbl';

CREATE INDEX idx_usertbl_addr 
   ON usertbl (addr);
   
SHOW INDEX FROM usertbl;

SHOW TABLE STATUS LIKE 'usertbl';

ANALYZE TABLE usertbl;
SHOW TABLE STATUS LIKE 'usertbl';

CREATE UNIQUE INDEX idx_usertbl_birtyYear
	ON usertbl (birthYear);

CREATE UNIQUE INDEX idx_usertbl_name
	ON usertbl (name);

SHOW INDEX FROM usertbl;

INSERT INTO usertbl VALUES('GPS', '김범수', 1983, '미국', NULL  , NULL  , 162, NULL);

CREATE INDEX idx_usertbl_name_birthYear
	ON usertbl (name,birthYear);
DROP INDEX idx_usertbl_name ON usertbl;

SHOW INDEX FROM usertbl;

SELECT * FROM usertbl WHERE name = '윤종신' and birthYear = '1969';

CREATE INDEX idx_usertbl_mobile1
	ON usertbl (mobile1);

SELECT * FROM usertbl WHERE mobile1 = '011';

SHOW INDEX FROM usertbl;

DROP INDEX idx_usertbl_addr ON usertbl;
DROP INDEX idx_usertbl_name_birthYear ON usertbl;
DROP INDEX idx_usertbl_mobile1 ON usertbl;

ALTER TABLE usertbl DROP INDEX idx_usertbl_addr;
ALTER TABLE usertbl DROP INDEX idx_usertbl_name_birthYear;
ALTER TABLE usertbl DROP INDEX idx_usertbl_mobile1;

ALTER TABLE usertbl DROP PRIMARY KEY;

SELECT table_name, constraint_name
    FROM information_schema.referential_constraints
    WHERE constraint_schema = 'sqldb';

ALTER TABLE buyTbl DROP FOREIGN KEY buytbl_ibfk_1;
ALTER TABLE usertbl DROP PRIMARY KEY;

