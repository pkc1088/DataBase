SELECT name, height
   FROM usertbl 
   WHERE height = (SELECT MAX(height) FROM usertbl) 
       OR height = (SELECT MIN(height) FROM usertbl) ;
       

SELECT COUNT(*) FROM usertbl;
SELECT COUNT(mobile1) AS '�޴����� �ִ� �����' FROM usertbl;
