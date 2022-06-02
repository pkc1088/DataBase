
SELECT name, height FROM usertbl 
   WHERE height > (SELECT height FROM usertbl WHERE Name = '김경호');

SELECT name, height FROM usertbl 
   WHERE height >= (SELECT height FROM usertbl WHERE addr = '경남');

SELECT name, height FROM usertbl 
   WHERE height >= ANY (SELECT height FROM usertbl WHERE addr = '경남');

SELECT name, height FROM usertbl 
   WHERE height >= ALL (SELECT height FROM usertbl WHERE addr = '경남');

SELECT name, height FROM usertbl 
   WHERE height = ANY (SELECT height FROM usertbl WHERE addr = '경남');
   
SELECT name, height FROM usertbl 
  WHERE height IN (SELECT height FROM usertbl WHERE addr = '경남');

// =ANY(서브쿼리)는 IN(서브쿼리)와 동일 
