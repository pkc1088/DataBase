USE tabledb;
CREATE VIEW v_usertbl
AS
	SELECT userid, name, addr FROM usertbl;

SELECT * FROM v_usertbl;  -- �並 ���̺��̶�� �����ص� ����

CREATE VIEW v_userbuytbl
AS
SELECT U.userid, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '����ó'
FROM usertbl U
	INNER JOIN buytbl B
	 ON U.userid = B.userid ;

SELECT * FROM v_userbuytbl WHERE name = '�����';


CREATE VIEW v_userbuytbl
AS
   SELECT U.userid AS 'USER ID', U.name AS 'USER NAME', B.prodName AS 'PRODUCT NAME', 
		U.addr, CONCAT(U.mobile1, U.mobile2) AS 'MOBILE PHONE'
      FROM usertbl U
	INNER JOIN buytbl B
	 ON U.userid = B.userid;

SELECT `USER ID`, `USER NAME` FROM v_userbuytbl; -- ����! ��ƽ�� ����Ѵ�.

ALTER VIEW v_userbuytbl
AS
   SELECT U.userid AS '����� ���̵�', U.name AS '�̸�', B.prodName AS '��ǰ �̸�', 
		U.addr, CONCAT(U.mobile1, U.mobile2)  AS '��ȭ ��ȣ'
      FROM usertbl U
          INNER JOIN buytbl B
             ON U.userid = B.userid ;

SELECT `�̸�`,`��ȭ ��ȣ` FROM v_userbuytbl;

DROP VIEW v_userbuytbl;

USE sqlDB;
CREATE OR REPLACE VIEW v_usertbl
AS
	SELECT userid, name, addr FROM usertbl;

DESCRIBE v_usertbl;

SHOW CREATE VIEW v_usertbl;

UPDATE v_usertbl SET addr = '�λ�' WHERE userid='JKW' ;

INSERT INTO v_usertbl(userid, name, addr) VALUES('KBM','�躴��','���') ;

CREATE VIEW v_sum
AS
	SELECT userid AS 'userid', SUM(price*amount) AS 'total'  
	   FROM buytbl GROUP BY userid;

SELECT * FROM v_sum;

SELECT * FROM INFORMATION_SCHEMA.VIEWS
     WHERE TABLE_SCHEMA = 'sqldb' AND TABLE_NAME = 'v_sum';

CREATE VIEW v_height177
AS
	SELECT * FROM usertbl WHERE height >= 177 ;

SELECT * FROM v_height177 ;

DELETE FROM v_height177 WHERE height < 177 ;

INSERT INTO v_height177 VALUES('KBM', '�躴��', 1977 , '���', '010', '5555555', 158, '2023-01-01') ;

ALTER VIEW v_height177
AS
	SELECT * FROM usertbl WHERE height >= 177
	    WITH CHECK OPTION ;

INSERT INTO v_height177 VALUES('WDT', '������', 2006 , '����', '010', '3333333', 155, '2023-3-3') ;

CREATE VIEW v_userbuytbl
AS
  SELECT U.userid, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS mobile
   FROM usertbl U
      INNER JOIN buytbl B
         ON U.userid = B.userid ;

INSERT INTO v_userbuytbl VALUES('PKL','�ڰ渮','�ȭ','���','00000000000','2023-2-2');
// -- �� �� �̻��� ���̺��� ���õ� ��� ������Ʈ�� �� ���� 
DROP TABLE IF EXISTS buytbl, usertbl;

SELECT * FROM v_userbuytbl;

CHECK TABLE v_userbuytbl;
