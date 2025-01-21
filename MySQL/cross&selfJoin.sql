
USE sqldb;
SELECT * 
   FROM buytbl 
     CROSS JOIN usertbl ;

SELECT * 
   FROM buytbl , usertbl ;

USE employees;
SELECT  COUNT(*) AS '�����Ͱ���'
   FROM employees 
     CROSS JOIN titles;

///
USE sqldb;
CREATE TABLE empTbl (emp CHAR(3), manager CHAR(3), empTel VARCHAR(8));

INSERT INTO empTbl VALUES('������',NULL,'0000');
INSERT INTO empTbl VALUES('���繫','������','2222');
INSERT INTO empTbl VALUES('�����','���繫','2222-1');
INSERT INTO empTbl VALUES('�̺���','���繫','2222-2');
INSERT INTO empTbl VALUES('��븮','�̺���','2222-2-1');
INSERT INTO empTbl VALUES('�����','�̺���','2222-2-2');
INSERT INTO empTbl VALUES('�̿���','������','1111');
INSERT INTO empTbl VALUES('�Ѱ���','�̿���','1111-1');
INSERT INTO empTbl VALUES('������','������','3333');
INSERT INTO empTbl VALUES('������','������','3333-1');
INSERT INTO empTbl VALUES('������','������','3333-1-1');

SELECT A.emp AS '��������' , B.emp AS '���ӻ��', B.empTel AS '���ӻ������ó'
   FROM empTbl A
      INNER JOIN empTbl B
         ON A.manager = B.emp
   WHERE A.emp = '��븮';
