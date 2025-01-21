
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl 
( userID  CHAR(8) NOT NULL, 
  name    VARCHAR(10) NOT NULL, 
  birthYear   INT NOT NULL,  
  CONSTRAINT PRIMARY KEY PK_usertbl_userID (userID)	//-- Ű �̸� �ʿ������ Ű �̸� ��������
);

DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl 
(   userID  CHAR(8) NOT NULL, 
    name    VARCHAR(10) NOT NULL, 
    birthYear   INT NOT NULL
);
ALTER TABLE usertbl
     ADD CONSTRAINT PK_usertbl_userID 
		PRIMARY KEY (userID);//	-- �̹� ������� ���̺��� �����ϴ°��� alter��


CREATE TABLE prodTbl
( prodCode CHAR(3) NOT NULL,
  prodID   CHAR(4)  NOT NULL,
  prodDate DATETIME  NOT NULL,
  prodCur  CHAR(10) NULL
);
ALTER TABLE prodTbl
	ADD CONSTRAINT PK_prodTbl_proCode_prodID 
		PRIMARY KEY (prodCode, prodID) ;// -- prodcode�� proID�� ���ļ� �⺻Ű�� ������ 

//table �ȿ�   CONSTRAINT PK_prodTbl_proCode_prodID 
	//			PRIMARY KEY (prodCode, prodID)  �־ ������ 
	
//fk ������ ���
CREATE TABLE buytbl 
(  num INT AUTO_INCREMENT NOT NULL PRIMARY KEY , 
   userID  CHAR(8) NOT NULL, 
   prodName CHAR(6) NOT NULL,
   CONSTRAINT FK_usertbl_buytbl FOREIGN KEY(userID) REFERENCES usertbl(userID)
);

// �� Ȥ�� �Ʒ��� �������� 
DROP TABLE IF EXISTS buytbl;
CREATE TABLE buytbl 
(  num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   userID  CHAR(8) NOT NULL, 
   prodName CHAR(6) NOT NULL 
);
ALTER TABLE buytbl
    ADD CONSTRAINT FK_usertbl_buytbl 
    FOREIGN KEY (userID) 
    REFERENCES usertbl(userID); 
    
    
// �⺻���̺� ���� �����͸� �ܷ����̺��� fk�� ���� ������ �߰��Ҽ� ���� 
// �׷��� set foreign key�� 0���� ����� �߰��� �ٽ� 1�� �ٲ��ִ��� �ؾ��� 


USE sqldb;
ALTER TABLE usertbl
	ADD homepage VARCHAR(30)  -- ���߰�
		DEFAULT 'http://www.hanbit.co.kr' -- ����Ʈ��
		NULL; -- Null �����
select * from usertbl;

ALTER TABLE usertbl
	DROP COLUMN mobile1;	// -- �������������� set foreign key 0���� ������ؾ���

ALTER TABLE usertbl
	CHANGE COLUMN name uName VARCHAR(20) NULL ;

ALTER TABLE usertbl
	DROP PRIMARY KEY; 

ALTER TABLE buytbl
	DROP FOREIGN KEY buytbl_ibfk_1;
	
// fk �����Ǿ������鼭 �θ����̺��� �⺻Ű�� �����Ҽ� ���� 
// foreignkeycheck�� 0���� ������ؾ��� (�⺻Ű �ƴѰ� drop column ������ ������ 
UPDATE usertbl SET userID = 'VVK' WHERE userID='BBK';
SET foreign_key_checks = 0;
UPDATE usertbl SET userID = 'VVK' WHERE userID='BBK';
SET foreign_key_checks = 1;

