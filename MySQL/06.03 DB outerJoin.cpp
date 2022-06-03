USE sqldb;
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '����ó'
   FROM usertbl U
      LEFT OUTER JOIN buytbl B
         ON U.userID = B.userID 
   ORDER BY U.userID, B.prodName;
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '����ó'
   FROM buytbl B
      LEFT OUTER JOIN usertbl U
         ON U.userID = B.userID 
   ORDER BY U.userID, B.prodName;
-- left outer join�� �ǹ̴� ���� ���̺��� ���� ��� ��µž��� �̶�� ��

SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '����ó'
   FROM buytbl B 
      RIGHT OUTER JOIN usertbl U
         ON U.userID = B.userID 
   ORDER BY U.userID;

SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '����ó'
   FROM usertbl U
      LEFT OUTER JOIN buytbl B
         ON U.userID = B.userID 
   WHERE B.prodName IS NULL
   ORDER BY U.userID;


