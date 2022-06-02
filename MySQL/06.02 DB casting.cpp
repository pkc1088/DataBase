SELECT CAST('2020-10-19 12:35:29.123' AS DATE) AS 'DATE' ;
SELECT CAST('2020-10-19 12:35:29.123' AS TIME) AS 'TIME' ;
SELECT CAST('2020-10-19 12:35:29.123' AS DATETIME) AS 'DATETIME' ; 

USE sqldb ;
SELECT AVG(amount) AS '��� ���� ����' FROM buytbl ;

SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '��� ���� ����'  FROM buytbl ;
-- �Ǵ�
SELECT CONVERT(AVG(amount) , SIGNED INTEGER) AS '��� ���� ����'  FROM buytbl ;

SELECT CAST('2020$12$12' AS DATE);
SELECT CAST('2020/12/12' AS DATE);
SELECT CAST('2020%12%12' AS DATE);
SELECT CAST('2020@12@12' AS DATE);

SELECT num, CONCAT(CAST(price AS CHAR(10)), 'X', CAST(amount AS CHAR(4)) ,'=' )  AS '�ܰ�X����',
	price*amount AS '���ž�' 
  FROM buytbl ;

SELECT '100' + '200' ; -- ���ڿ� ���ڸ� ���� (������ ��ȯ�Ǽ� �����)
SELECT CONCAT('100', '200'); -- ���ڿ� ���ڸ� ���� (���ڷ� ó��)
SELECT CONCAT(100, '200'); -- ������ ���ڸ� ���� (������ ���ڷ� ��ȯ�Ǽ� ó��)
SELECT 1 > '2mega'; -- ������ 2�� ��ȯ�Ǿ ��
SELECT 3 > '2MEGA'; -- ������ 2�� ��ȯ�Ǿ ��
SELECT 0 = 'mega2'; -- ���ڴ� 0���� ��ȯ��
