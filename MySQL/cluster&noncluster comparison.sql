
CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
DROP TABLE IF EXISTS clustertbl;
CREATE TABLE clustertbl -- Cluster Table ����
( userID  CHAR(8) ,
  name    VARCHAR(10) 
);
INSERT INTO clustertbl VALUES('LSG', '�̽±�');
INSERT INTO clustertbl VALUES('KBS', '�����');
INSERT INTO clustertbl VALUES('KKH', '���ȣ');
INSERT INTO clustertbl VALUES('JYP', '������');
INSERT INTO clustertbl VALUES('SSK', '���ð�');
INSERT INTO clustertbl VALUES('LJB', '�����');
INSERT INTO clustertbl VALUES('YJS', '������');
INSERT INTO clustertbl VALUES('EJW', '������');
INSERT INTO clustertbl VALUES('JKW', '������');
INSERT INTO clustertbl VALUES('BBK', '�ٺ�Ŵ');

SELECT * FROM clustertbl;

ALTER TABLE clustertbl
	ADD CONSTRAINT PK_clustertbl_userID
		PRIMARY KEY (userID);

SELECT * FROM clustertbl;

CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
DROP TABLE IF EXISTS secondarytbl;
CREATE TABLE secondarytbl -- Secondary Table ����
( userID  CHAR(8),
  name    VARCHAR(10)
);
INSERT INTO secondarytbl VALUES('LSG', '�̽±�');
INSERT INTO secondarytbl VALUES('KBS', '�����');
INSERT INTO secondarytbl VALUES('KKH', '���ȣ');
INSERT INTO secondarytbl VALUES('JYP', '������');
INSERT INTO secondarytbl VALUES('SSK', '���ð�');
INSERT INTO secondarytbl VALUES('LJB', '�����');
INSERT INTO secondarytbl VALUES('YJS', '������');
INSERT INTO secondarytbl VALUES('EJW', '������');
INSERT INTO secondarytbl VALUES('JKW', '������');
INSERT INTO secondarytbl VALUES('BBK', '�ٺ�Ŵ');


ALTER TABLE secondarytbl
	ADD CONSTRAINT UK_secondarytbl_userID
		UNIQUE (userID);

SELECT * FROM secondarytbl;

INSERT INTO clustertbl VALUES('FNT', 'Ǫ��Ÿ');
INSERT INTO clustertbl VALUES('KAI', 'ī����');

INSERT INTO secondarytbl VALUES('FNT', 'Ǫ��Ÿ');
INSERT INTO secondarytbl VALUES('KAI', 'ī����');

