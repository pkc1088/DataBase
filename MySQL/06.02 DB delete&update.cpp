UPDATE testTbl4
    SET Lname = '����'
    WHERE Fname = 'Kyoichi';
select * from testtbl4 ;

USE sqldb;
UPDATE buytbl SET price = price * 1.5 ;

USE sqldb;
DELETE FROM testTbl4 WHERE Fname = 'Aamer';

DELETE FROM testTbl4 WHERE Fname = 'Aamer'  LIMIT 5;

DELETE FROM bigTbl1; // -- �ະ�� ���� 
DROP TABLE bigTbl2;	// ��ü���� 
TRUNCATE TABLE bigTbl3; // delete�� ���� but Ʈ����� �α׸� ������� �ʾ� �ӵ�����

