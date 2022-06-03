USE sqldb;
CREATE TABLE pivotTest
   (  uName CHAR(3),
      season CHAR(2),
      amount INT );

INSERT  INTO  pivotTest VALUES
	('�����' , '�ܿ�',  10) , ('������' , '����',  15) , ('�����' , '����',  25) , ('�����' , '��',    3) ,
	('�����' , '��',    37) , ('������' , '�ܿ�',  40) , ('�����' , '����',  14) ,('�����' , '�ܿ�',  22) ,
	('������' , '����',  64) ;
SELECT * FROM pivotTest;

SELECT uName, 
  SUM(IF(season='��', amount, 0)) AS '��', 
  SUM(IF(season='����', amount, 0)) AS '����',
  SUM(IF(season='����', amount, 0)) AS '����',
  SUM(IF(season='�ܿ�', amount, 0)) AS '�ܿ�',
  SUM(amount) AS '�հ�' FROM pivotTest GROUP BY uName ;

