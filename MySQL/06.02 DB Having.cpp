USE sqldb;

SELECT userID AS '사용자', SUM(price*amount) AS '총구매액'  
   FROM buytbl 
   WHERE SUM(price*amount) > 1000 -- 이렇게는 사용불가 
   GROUP BY userID ;		 

SELECT userID AS '사용자', SUM(price*amount) AS '총구매액'  
   FROM buytbl 
   GROUP BY userID
   HAVING SUM(price*amount) > 1000 ;
   
SELECT userID AS '사용자', SUM(price*amount) AS '총구매액'  
   FROM buytbl 
   GROUP BY userID
   HAVING SUM(price*amount) > 1000 
   ORDER BY SUM(price*amount) ;
