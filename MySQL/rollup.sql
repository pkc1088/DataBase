USE sqldb;

SELECT num, groupName, SUM(price * amount) AS '���' 
   FROM buytbl
   GROUP BY  groupName, num
   WITH ROLLUP;

SELECT groupName, SUM(price * amount) AS '���' 
   FROM buytbl
   GROUP BY  groupName
   WITH ROLLUP;

