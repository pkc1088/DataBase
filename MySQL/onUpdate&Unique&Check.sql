
ALTER TABLE buytbl
	DROP FOREIGN KEY FK_usertbl_buytbl; -- �ܷ� Ű ����
ALTER TABLE buytbl
	ADD CONSTRAINT FK_usertbl_buytbl
	FOREIGN KEY (userID)
	REFERENCES usertbl (userID)
	ON UPDATE CASCADE;	// -- �������̺� ������ ����� �ܷ�Ű ���̺� �ڵ����� ���� ON DELETE CASCADE�� ����

USE tabledb;
DROP TABLE IF EXISTS buytbl, usertbl;
CREATE TABLE usertbl 
( userID  CHAR(8) NOT NULL PRIMARY KEY, 
  name    VARCHAR(10) NOT NULL, 
  birthYear   INT NOT NULL,  
  email   CHAR(30) NULL  UNIQUE
);
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl 
( userID  CHAR(8) NOT NULL PRIMARY KEY,
  name    VARCHAR(10) NOT NULL, 
  birthYear   INT NOT NULL,  
  email   CHAR(30) NULL ,  
  CONSTRAINT AK_email  UNIQUE (email)
);
// -- uniqe�� pk���̴� ���ڴ� null�� �����ϴٴ���

//-- ��������� 1900�� ���� �׸��� 2023�� ����, �̸��� �ݵ�� �־�� ��.
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl 
( userID  CHAR(8) PRIMARY KEY,
  name    VARCHAR(10) , 
  birthYear  INT CHECK  (birthYear >= 1900 AND birthYear <= 2023),
  mobile1	char(3) NULL, 
  CONSTRAINT CK_name CHECK ( name IS NOT NULL)  
);

ALTER TABLE usertbl
	ADD CONSTRAINT CK_mobile1
	CHECK  (mobile1 IN ('010','011','016','017','018','019')) ;
	
	// check ���� ����� �۵���ġ������ ���ǵڿ� NOT ENFORCED  �߰� 

