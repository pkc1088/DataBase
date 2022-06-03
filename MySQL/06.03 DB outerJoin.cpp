USE sqldb;
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처'
   FROM usertbl U
      LEFT OUTER JOIN buytbl B
         ON U.userID = B.userID 
   ORDER BY U.userID, B.prodName;
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처'
   FROM buytbl B
      LEFT OUTER JOIN usertbl U
         ON U.userID = B.userID 
   ORDER BY U.userID, B.prodName;
-- left outer join의 의미는 왼쪽 테이블의 것은 모두 출력돼야함 이라는 뜻

SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처'
   FROM buytbl B 
      RIGHT OUTER JOIN usertbl U
         ON U.userID = B.userID 
   ORDER BY U.userID;

SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)  AS '연락처'
   FROM usertbl U
      LEFT OUTER JOIN buytbl B
         ON U.userID = B.userID 
   WHERE B.prodName IS NULL
   ORDER BY U.userID;


