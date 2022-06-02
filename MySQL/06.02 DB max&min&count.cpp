SELECT name, height
   FROM usertbl 
   WHERE height = (SELECT MAX(height) FROM usertbl) 
       OR height = (SELECT MIN(height) FROM usertbl) ;
       

SELECT COUNT(*) FROM usertbl;
SELECT COUNT(mobile1) AS '휴대폰이 있는 사용자' FROM usertbl;
