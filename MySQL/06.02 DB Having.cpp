USE sqldb;

SELECT userID AS '�����', SUM(price*amount) AS '�ѱ��ž�'  
   FROM buytbl 
   WHERE SUM(price*amount) > 1000 -- �̷��Դ� ���Ұ� 
   GROUP BY userID ;		 

SELECT userID AS '�����', SUM(price*amount) AS '�ѱ��ž�'  
   FROM buytbl 
   GROUP BY userID
   HAVING SUM(price*amount) > 1000 ;
   
SELECT userID AS '�����', SUM(price*amount) AS '�ѱ��ž�'  
   FROM buytbl 
   GROUP BY userID
   HAVING SUM(price*amount) > 1000 
   ORDER BY SUM(price*amount) ;
