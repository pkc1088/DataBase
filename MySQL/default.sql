CREATE TABLE usertbl 
( userID  	CHAR(8) NOT NULL PRIMARY KEY,  
  name    	VARCHAR(10) NOT NULL, 
  birthYear	INT NOT NULL DEFAULT -1,
  addr	  	CHAR(2) NOT NULL DEFAULT '����',
  mobile1	CHAR(3) NULL, 
  mobile2	CHAR(8) NULL, 
  height	SMALLINT NULL DEFAULT 170, 
  mDate    	DATE NULL
);

ALTER TABLE usertbl
	ALTER COLUMN birthYear SET DEFAULT -1;
ALTER TABLE usertbl
	ALTER COLUMN addr SET DEFAULT '����';
ALTER TABLE usertbl
	ALTER COLUMN height SET DEFAULT 170;

//-- default ���� DEFAULT�� ������ ���� �ڵ� �Է��Ѵ�.
INSERT INTO usertbl VALUES ('LHL', '������', default, default, '011', '1234567', default, '2023.12.12');
//-- ���̸��� ��õ��� ������ DEFAULT�� ������ ���� �ڵ� �Է��Ѵ�
INSERT INTO usertbl(userID, name) VALUES('KAY', '��ƿ�');
//-- ���� ���� ���Ǹ� DEFAULT�� ������ ���� ���õȴ�.
INSERT INTO usertbl VALUES ('WB', '����', 1982, '����', '019', '9876543', 176, '2020.5.5');
SELECT * FROM usertbl;
